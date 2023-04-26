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
  final BuildContext context;
  late final User user;

  SubjectService({required this.context}) {
    if (Provider.of<UserProvider>(context, listen: false).user != null) {
      user = Provider.of<UserProvider>(context, listen: false).user!;
    }
  }

  Future<bool> getSubjects() async {
    http.Response response = await client.get(
      Uri.parse("${WebClient.baseUrl}users/${user.id}/subjects"),
      headers: {
        "Authorization": "Bearer ${user.accessToken}",
      },
    );

    if (response.statusCode != 200) {
      if (json.decode(response.body).toString() == "Cannot find subjects") {
        throw const HttpException("Cannot find subjects");
      }
      throw HttpException(response.body.toString());
    }

    return saveInfoFromResponse(response.body);
  }

  Future<bool> saveInfoFromResponse(String body) async {
    final List<Subject> subjects = json
        .decode(body)
        .map<Subject>((subject) => Subject.fromJson(subject))
        .toList();
    Provider.of<SubjectsProvider>(context, listen: false).setSubjects(subjects);

    return true;
  }
}
