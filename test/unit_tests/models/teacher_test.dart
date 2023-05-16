import 'package:flutter_test/flutter_test.dart';
import 'package:c317_mobile/models/teacher.dart';

void main() {
  group('Teacher', () {
    late Teacher teacher;

    setUp(() {
      teacher = Teacher(
        id: 1,
        name: 'John Doe',
        email: 'johndoe@example.com',
        department: 'Math',
        phone: '123-456-7890',
      );
    });

    test('should have correct properties', () {
      expect(teacher.id, 1);
      expect(teacher.name, 'John Doe');
      expect(teacher.email, 'johndoe@example.com');
      expect(teacher.department, 'Math');
      expect(teacher.phone, '123-456-7890');
    });

    test('should create Teacher from json', () {
      final json = {
        'id': 1,
        'name': 'John Doe',
        'email': 'johndoe@example.com',
        'departament': 'Math',
        'phone_number': '123-456-7890',
        'subject_id': 1,
      };
      final teacher = Teacher.fromJson(json);
      expect(teacher.id, 1);
      expect(teacher.name, 'John Doe');
      expect(teacher.email, 'johndoe@example.com');
      expect(teacher.department, 'Math');
      expect(teacher.phone, '123-456-7890');
    });
  });
}
