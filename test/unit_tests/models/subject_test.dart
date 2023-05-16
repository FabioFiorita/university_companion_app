import 'package:c317_mobile/models/teacher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:c317_mobile/models/subject.dart';
import 'package:mockito/mockito.dart';

class MockTeacher extends Mock implements Teacher {}

void main() {
  group('Subject', () {
    late Subject subject;
    late MockTeacher mockTeacher;

    setUp(() {
      mockTeacher = MockTeacher();
      subject = Subject(
        id: 'C317',
        name: 'Tópicos Especiais',
        teacher: mockTeacher,
      );
    });

    test('should have correct properties', () {
      expect(subject.id, 'C317');
      expect(subject.name, 'Tópicos Especiais');
    });

    test('should create Subject from json', () {
      final json = {
        'id': 'C317',
        'name': 'Tópicos Especiais',
      };
      final subject = Subject.fromJson(json, mockTeacher);
      expect(subject.id, 'C317');
      expect(subject.name, 'Tópicos Especiais');
    });
  });
}
