import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:c317_mobile/models/class.dart';
import 'package:c317_mobile/models/subject.dart';

class MockSubject extends Mock implements Subject {}

void main() {
  group('Class', () {
    late Class classObj;
    late MockSubject mockSubject;

    setUp(() {
      mockSubject = MockSubject();
      classObj = Class(
        id: 1,
        day: 'Monday',
        time: '10:00 AM',
        subject: mockSubject,
      );
    });

    test('should have correct properties', () {
      expect(classObj.id, 1);
      expect(classObj.day, 'Monday');
      expect(classObj.time, '10:00 AM');
      expect(classObj.subject, mockSubject);
    });

    test('should create Class from json', () {
      final json = {
        'id': 1,
        'day': 'Monday',
        'time': '10:00 AM',
        'subject_id': 1,
      };
      final subject = MockSubject();
      final classObj = Class.fromJson(json, subject);
      expect(classObj.id, 1);
      expect(classObj.day, 'Monday');
      expect(classObj.time, '10:00 AM');
      expect(classObj.subject, subject);
    });
  });
}
