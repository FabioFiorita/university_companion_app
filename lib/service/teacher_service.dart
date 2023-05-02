import 'dart:convert';

import 'package:c317_mobile/exceptions/teacher_exception.dart';
import 'package:http/http.dart' as http;

import '../exceptions/general_exception.dart';
import '../http/web_client.dart';
import '../models/teacher.dart';

class TeacherService {
  http.Client client = WebClient().client;

  Future<List<Teacher>> getTeachers() async {
    try {
      http.Response response = await client
          .get(
            Uri.parse("${WebClient.baseUrl}teachers"),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        _handleStatusCode(response);
      }

      return saveInfoFromResponse(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Teacher>> saveInfoFromResponse(String body) async {
    final List<Teacher> teachers = json
        .decode(body)
        .map<Teacher>((subject) => Teacher.fromJson(subject))
        .toList();

    return teachers;
  }

  void _handleStatusCode(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // success
        break;
      case 400:
        throw GeneralException.undefined;
      case 404:
        throw TeacherException.teacherNotFound;
      case 429:
        throw GeneralException.tooManyRequests;
      default:
        throw GeneralException.undefined;
    }
  }
}
