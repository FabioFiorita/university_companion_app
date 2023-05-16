import 'package:c317_mobile/exceptions/subject_exception.dart';
import 'package:c317_mobile/http/web_client.dart';
import 'package:c317_mobile/models/subject.dart';
import 'package:c317_mobile/models/user.dart';
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
  group('SubjectService', () {
    late SubjectService service;
    late TeacherService teacherService;
    late User user;

    setUp(() {
      user = MockUser();
      teacherService = TeacherService()
        ..client = MockClient((request) async {
          return http.Response(MockJsonTeacher.single, 200);
        });
    });

    test('getSubjects should return a list of subjects', () async {
      service = SubjectService()
        ..client = MockClient((request) async {
          expect(request.url.toString(),
              equals('${WebClient.baseUrl}student/${user.id}'));
          return http.Response(MockJsonSubject.list, 200);
        })
        ..teacherService = teacherService;

      final subjects = await service.getSubjects(user);

      expect(subjects, isA<List>());
      expect(subjects.length, equals(3));
      expect(subjects[0].id, equals('C206'));
      expect(subjects[0].name, equals('POO'));
      expect(subjects[1].id, equals('C103'));
      expect(subjects[1].name, equals('Algoritmos III'));
      expect(subjects[2].id, equals('C317'));
      expect(subjects[2].name, equals('Topicos Especiais'));
    });

    test(
        'getSubjects should throw SubjectException.subjectNotFound for a non-200 status code',
        () async {
      service = SubjectService()
        ..client = MockClient((request) async {
          expect(request.url.toString(),
              equals('${WebClient.baseUrl}student/${user.id}'));
          return http.Response('', 404);
        });
      expect(() => service.getSubjects(user),
          throwsA(SubjectException.subjectNotFound));
    });
  });
}
