import 'dart:convert';
import 'dart:io';

import 'package:c317_mobile/models/subject.dart';
import 'package:c317_mobile/providers/subjects_provider.dart';
import 'package:c317_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../http/web_client.dart';
import '../models/user.dart';

class SubjectService {
  http.Client client = WebClient().client;

  Future<List<Subject>> getSubjects(User user) async {
    http.Response response = await client.get(
      Uri.parse("${WebClient.baseUrl}users/${user.id}/subjects"),
      headers: {
        "Authorization": "Bearer ${user.accessToken}",
      },
    ).timeout(const Duration(seconds: 5));

    if (response.statusCode != 200) {
      if (json.decode(response.body).toString() == "Cannot find subjects") {
        throw const HttpException("Cannot find subjects");
      }
      throw HttpException(response.body.toString());
    }

    return saveInfoFromResponse(response.body);
  }

  Future<List<Subject>> saveInfoFromResponse(String body) async {
    final List<Subject> subjects = json
        .decode(body)
        .map<Subject>((subject) => Subject.fromJson(subject))
        .toList();

    return subjects;
  }
}
