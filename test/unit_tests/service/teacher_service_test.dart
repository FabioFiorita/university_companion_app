import 'package:c317_mobile/exceptions/teacher_exception.dart';
import 'package:c317_mobile/http/web_client.dart';
import 'package:c317_mobile/models/teacher.dart';
import 'package:c317_mobile/models/user.dart';
import 'package:c317_mobile/service/teacher_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../data/mock_json_consts.dart';

class MockUser extends Mock implements User {
  @override
  String get accessToken => 'accessToken';
}

void main() {
  group('TeacherService', () {
    late TeacherService service;
    late User user;

    setUp(() {
      user = MockUser();
    });

    test('getTeacherById should return a teacher', () async {
      service = TeacherService()
        ..client = MockClient((request) async {
          expect(request.url.toString(),
              equals('${WebClient.baseUrl}professor/1'));
          return http.Response(MockJsonTeacher.single, 200);
        });
      final Teacher teacher = await service.getTeacherById(1, user);
      expect(teacher, isA<Teacher>());
      expect(teacher.id, 1);
      expect(teacher.name, 'Fabio');
      expect(teacher.email, 'fabio@inatel.br');
      expect(teacher.department, 'Computer Science');
      expect(teacher.phone, '98822-6501');
    });

    test(
        'getTeacherById should throw TeacherException.teacherNotFound for a non-200 status code',
        () async {
      service = TeacherService()
        ..client = MockClient((request) async {
          expect(request.url.toString(),
              equals('${WebClient.baseUrl}professor/1'));
          return http.Response('', 404);
        });
      expect(() => service.getTeacherById(1, user),
          throwsA(TeacherException.teacherNotFound));
    });

    test('getTeachers should return a list of teachers', () async {
      service = TeacherService()
        ..client = MockClient((request) async {
          expect(
              request.url.toString(), equals('${WebClient.baseUrl}professor'));
          return http.Response(MockJsonTeacher.list, 200);
        });
      final teachers = await service.getTeachers(user);

      expect(teachers, isA<List<Teacher>>());
      expect(teachers.length, equals(2));
      expect(teachers[0].id, equals(1));
      expect(teachers[0].name, equals('Fabio'));
      expect(teachers[0].email, equals('fabio@inatel.br'));
      expect(teachers[0].phone, equals('98822-6501'));
    });

    test(
        'getTeachers should throw TeacherException.teacherNotFound for a non-200 status code',
        () async {
      service = TeacherService()
        ..client = MockClient((request) async {
          expect(
              request.url.toString(), equals('${WebClient.baseUrl}professor'));
          return http.Response('', 404);
        });
      expect(() => service.getTeachers(user),
          throwsA(TeacherException.teacherNotFound));
    });

    test(
        'getTeachers should return an empty list when the server returns an empty list',
        () async {
      service = TeacherService()
        ..client = MockClient((request) async {
          expect(
              request.url.toString(), equals('${WebClient.baseUrl}professor'));
          return http.Response('[]', 200);
        });
      final teachers = await service.getTeachers(user);

      expect(teachers, isA<List<Teacher>>());
      expect(teachers.length, equals(0));
    });
  });
}