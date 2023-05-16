import 'dart:convert';

import 'package:c317_mobile/exceptions/exam_exception.dart';
import 'package:c317_mobile/models/exam.dart';
import 'package:c317_mobile/service/subject_service.dart';
import 'package:http/http.dart' as http;

import '../http/web_client.dart';
import '../models/subject.dart';
import '../models/user.dart';
import '../utils/response_handler.dart';

class ExamService {
  http.Client client = WebClient().client;
  SubjectService subjectService = SubjectService();

  Future<List<Exam>> getExams(User user) async {
    try {
      http.Response response = await client
          .get(Uri.parse("${WebClient.baseUrl}student/${user.id}"), headers: {
        "Authorization": "Bearer ${user.accessToken}",
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, ExamException.gradeNotFound);
      }

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, ExamException.gradeNotFound);
      }

      return saveInfoFromResponse(response.body, user);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getGrade(User user, int examId) async {
    try {
      http.Response response = await client
          .get(Uri.parse("${WebClient.baseUrl}exam/$examId"), headers: {
        "Authorization": "Bearer ${user.accessToken}",
      }).timeout(const Duration(seconds: 5));
      print("Grade response: $response");
      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, ExamException.gradeNotFound);
      }

      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Exam>> saveInfoFromResponse(String body, User user) async {
    final List<dynamic> decodedJson = jsonDecode(body)['exams'];
    print("Decoded json: $decodedJson");
    final List<Exam> grades = [];

    for (final exam in decodedJson) {
      print("Exam: $exam");
      final List<dynamic> subjects = jsonDecode(body)['subjects'];
      print("Subjects: $subjects");
      final String subjectId = subjects
          .firstWhere((subject) => subject['id'] == exam['subject_id'])['id'];
      print("Subject id: $subjectId");
      final Subject? subject =
          await subjectService.getSubjectById(subjectId, user);
      print("Subject: $subject");
      final String gradeResponse = await getGrade(user, exam['id']);
      print("Grade response: $gradeResponse");
      final int grade = jsonDecode(gradeResponse)['students']
          .firstWhere((student) => student['student_id'] == user.id)['grade']
          .toInt();
      print("Grade: $grade");
      if (subject != null) {
        final newGrade = Exam.fromJson(exam, grade, subject);
        grades.add(newGrade);
      }
    }

    return grades;
  }
}
