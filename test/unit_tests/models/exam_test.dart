import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:c317_mobile/models/exam.dart';
import 'package:c317_mobile/models/subject.dart';

class MockSubject extends Mock implements Subject {}

void main() {
  group('Exam', () {
    late Exam exam;
    late MockSubject mockSubject;

    setUp(() {
      mockSubject = MockSubject();
      exam = Exam(
        id: 1,
        code: 'ABC123',
        grade: 80,
        subject: mockSubject,
      );
    });

    test('should have correct properties', () {
      expect(exam.id, 1);
      expect(exam.code, 'ABC123');
      expect(exam.grade, 80);
      expect(exam.subject, mockSubject);
    });

    test('should create Exam from json', () {
      final json = {
        'id': 1,
        'code': 'ABC123',
      };
      final exam = Exam.fromJson(json, 80, mockSubject);
      expect(exam.id, 1);
      expect(exam.code, 'ABC123');
      expect(exam.grade, 80);
      expect(exam.subject, mockSubject);
    });
  });
}
