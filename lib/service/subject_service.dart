import 'dart:convert';
import 'dart:io';

import 'package:c317_mobile/exceptions/subject_exception.dart';
import 'package:c317_mobile/exceptions/user_exception.dart';
import 'package:c317_mobile/models/subject.dart';
import 'package:http/http.dart' as http;

import '../exceptions/general_exception.dart';
import '../http/web_client.dart';
import '../models/user.dart';

class SubjectService {
  http.Client client = WebClient().client;

  Future<List<Subject>> getSubjects(User user) async {
    try {
      http.Response response = await client.get(
          Uri.parse("${WebClient.baseUrl}users/${user.id}/subjects"),
          headers: {
            "Authorization": "Bearer ${user.accessToken}",
          }).timeout(const Duration(seconds: 5));
      // Uri.parse("${WebClient.baseUrl}subject"),
      // headers: {
      //   "content-type": "application/json",
      // }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        _handleStatusCode(response);
      }

      return saveInfoFromResponse(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Subject>> saveInfoFromResponse(String body) async {
    final List<Subject> subjects = json
        .decode(body)
        .map<Subject>((subject) => Subject.fromJson(subject))
        .toList();

    return subjects;
  }

  void _handleStatusCode(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // success
        break;
      case 400:
        throw GeneralException.undefined;
      case 401:
        throw UserException.sessionExpired;
      case 404:
        throw SubjectException.subjectNotFound;
      case 429:
        throw GeneralException.tooManyRequests;
      default:
        throw GeneralException.undefined;
    }
  }
}
