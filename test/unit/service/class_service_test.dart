import 'package:c317_mobile/exceptions/class_exception.dart';
import 'package:c317_mobile/http/web_client.dart';
import 'package:c317_mobile/models/class.dart';
import 'package:c317_mobile/models/user.dart';
import 'package:c317_mobile/service/class_service.dart';
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
  group('ClassService', () {
    late ClassService service;
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

    //TODO: should only return classes for the current user
    test('getClasses should return a list of classes', () async {
      service = ClassService()
        ..client = MockClient((request) async {
          expect(request.url.toString(),
              equals('${WebClient.baseUrl}class_schedule'));
          return http.Response(MockJsonClass.list, 200);
        })
        ..subjectService = subjectService;

      final classes = await service.getClasses(user);

      expect(classes, isA<List<Class>>());
      expect(classes.length, equals(4));
      expect(classes[0].id, equals(1));
      expect(classes[0].time, equals('08:00:00'));
      expect(classes[1].id, equals(2));
      expect(classes[1].day, equals('tuesday'));
    });

    test(
        'getClasses should throw ClassException.classNotFound for a non-200 status code',
        () async {
      service = ClassService()
        ..client = MockClient((request) async {
          expect(request.url.toString(),
              equals('${WebClient.baseUrl}class_schedule'));
          return http.Response('', 404);
        });
      expect(() => service.getClasses(user),
          throwsA(ClassException.classNotFound));
    });
  });
}
