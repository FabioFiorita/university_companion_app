import 'dart:convert';

import 'package:c317_mobile/exceptions/teacher_exception.dart';
import 'package:http/http.dart' as http;

import '../http/web_client.dart';
import '../models/teacher.dart';
import '../utils/response_handler.dart';

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
        ResponseHandler.handleStatusCode(
            response.statusCode, TeacherException.teacherNotFound);
      }

      return saveInfoFromResponse(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<Teacher> getTeacherById(int id) async {
    try {
      http.Response response = await client
          .get(
            Uri.parse("${WebClient.baseUrl}teachers/$id"),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, TeacherException.teacherNotFound);
      }

      return Teacher.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Teacher>> saveInfoFromResponse(String body) async {
    final List<Teacher> teachers = jsonDecode(body)
        .map<Teacher>((teacher) => Teacher.fromJson(teacher))
        .toList();

    return teachers;
  }
}
