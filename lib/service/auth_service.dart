import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../http/web_client.dart';
import '../models/user.dart';
import '../exceptions/login_exception.dart';

class AuthService {
  http.Client client = WebClient().client;

  Future<User> login(String email, String password) async {
    try {
      final http.Response response = await client.post(
        Uri.parse("${WebClient.baseUrl}login"),
        body: {"email": email, "password": password},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        _handleStatusCode(response);
      }

      return saveInfoFromResponse(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> saveInfoFromResponse(String body) async {
    final String accessToken = json.decode(body)["accessToken"];
    final User user = User.fromJson(json.decode(body)["user"], accessToken);

    return user;
  }

  void _handleStatusCode(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // success
        break;
      case 400:
        if (response.body.toLowerCase().contains("email")) {
          throw LoginException.invalidEmail;
        } else if (response.body.toLowerCase().contains("password")) {
          throw LoginException.wrongPassword;
        } else if (response.body.toLowerCase().contains("user")) {
          throw LoginException.userNotFound;
        } else {
          throw LoginException.undefined;
        }
      case 404:
        throw LoginException.userNotFound;
      case 429:
        throw LoginException.tooManyRequests;
      default:
        throw LoginException.undefined;
    }
  }
}
