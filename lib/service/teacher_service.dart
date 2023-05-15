import 'dart:convert';

import 'package:c317_mobile/exceptions/teacher_exception.dart';
import 'package:http/http.dart' as http;

import '../http/web_client.dart';
import '../models/teacher.dart';
import '../models/user.dart';
import '../utils/response_handler.dart';

class TeacherService {
  http.Client client = WebClient().client;

  Future<List<Teacher>> getTeachers(User user) async {
    try {
      http.Response response = await client
          .get(Uri.parse("${WebClient.baseUrl}professor"), headers: {
        "Authorization": "Bearer ${user.accessToken}"
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, TeacherException.teacherNotFound);
      }

      return saveInfoFromResponse(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<Teacher> getTeacherById(int id, User user) async {
    try {
      http.Response response = await client
          .get(Uri.parse("${WebClient.baseUrl}professor/$id"), headers: {
        "Authorization": "Bearer ${user.accessToken}"
      }).timeout(const Duration(seconds: 5));

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
    print("teacher body: $body");
    final List<Teacher> teachers = jsonDecode(body)
        .map<Teacher>((teacher) => Teacher.fromJson(teacher))
        .toList();

    return teachers;
  }
}
