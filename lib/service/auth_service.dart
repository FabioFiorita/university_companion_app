import 'dart:convert';
import 'dart:io';

import 'package:c317_mobile/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/user_not_found_exception.dart';
import '../http/web_client.dart';
import '../models/user.dart';

class AuthService {
  http.Client client = WebClient().client;
  final BuildContext context;

  AuthService({required this.context});

  Future<String> login(String email, String password) async {
    http.Response response = await client.post(
      Uri.parse("${WebClient.baseUrl}login"),
      body: {"email": email, "password": password},
    );

    if (response.statusCode != 200) {
      if (json.decode(response.body).toString() == "Cannot find user") {
        throw UserNotFoundException();
      }
      throw HttpException(response.body.toString());
    }

    return saveInfosFromResponse(response.body);
  }

  Future<String> saveInfosFromResponse(String body) async {
    final String accessToken = json.decode(body)["accessToken"];
    final User user = User.fromJson(json.decode(body)["user"], accessToken);
    Provider.of<UserProvider>(context, listen: false).setUser(user);

    return user.name;
  }
}
