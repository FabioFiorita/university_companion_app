import 'package:c317_mobile/exceptions/exam_exception.dart';
import 'package:c317_mobile/http/web_client.dart';
import 'package:c317_mobile/models/user.dart';
import 'package:c317_mobile/service/exam_service.dart';
import 'package:c317_mobile/service/subject_service.dart';
import 'package:c317_mobile/service/teacher_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../data/mock_json_consts.dart';

class MockUser extends Mock implements User {
  @override
  String get accessToken => 'accessToken';
  @override
  int get id => 1;
}

void main() {
  group('ExamService', () {
    late ExamService service;
    late SubjectService subjectService;
    late TeacherService teacherService;
    late User user;

    setUp(() {
      user = MockUser();
      teacherService = TeacherService()
        ..client = MockClient((request) async {
          return http.Response(MockJsonTeacher.single, 200);
        });
      subjectService = SubjectService()
        ..client = MockClient((request) async {
          return http.Response(MockJsonSubject.single, 200);
        })
        ..teacherService = teacherService;
    });

    test('getExams should return a list of exams', () async {
      service = ExamService()
        ..client = MockClient((request) async {
          final response = request.url.toString().contains('student/${user.id}')
              ? MockJsonExam.list
              : MockJsonExam.single;
          return http.Response(response, 200);
        })
        ..subjectService = subjectService;

      final exams = await service.getExams(user);
      expect(exams, isA<List>());
      expect(exams.length, equals(1));
      expect(exams[0].id, equals(2));
      expect(exams[0].code, equals('NP1'));
      expect(exams[0].subject.name, equals('Algoritmos III'));
    });

    test(
        'getExams should throw ExamException.examNotFound for a non-200 status code',
        () async {
      service = ExamService()
        ..client = MockClient((request) async {
          expect(request.url.toString(),
              equals('${WebClient.baseUrl}student/${user.id}'));
          return http.Response('', 404);
        });
      expect(
          () => service.getExams(user), throwsA(ExamException.gradeNotFound));
    });
  });
}
