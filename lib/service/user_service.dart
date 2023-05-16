import 'dart:convert';

import 'package:c317_mobile/exceptions/general_exception.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;

import '../exceptions/user_exception.dart';
import '../http/web_client.dart';
import '../models/user.dart';
import '../utils/response_handler.dart';

class UserService {
  http.Client client = WebClient().client;

  Future<User> login(String email, String password) async {
    try {
      final http.Response response = await client
          .post(
            Uri.parse("${WebClient.baseUrl}login/"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, _handle400StatusCode(response));
      }

      return saveInfoFromResponse(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> saveInfoFromResponse(String body) async {
    final String accessToken = jsonDecode(body)["token"];
    final jwt = JWT.decode(accessToken);
    print(jwt.payload);
    final User user = User.fromJson(jwt.payload, accessToken);
    return user;
  }

  Exception _handle400StatusCode(http.Response response) {
    if (response.statusCode == 400) {
      if (response.body.toLowerCase().contains("email")) {
        return UserException.invalidEmail;
      } else if (response.body.toLowerCase().contains("password")) {
        return UserException.wrongPassword;
      } else if (response.body.toLowerCase().contains("user")) {
        return UserException.userNotFound;
      }
    }
    if (response.statusCode == 401) {
      return UserException.unauthorized;
    }
    return GeneralException.undefined;
  }
}
