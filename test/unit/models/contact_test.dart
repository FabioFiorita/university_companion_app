import 'package:flutter_test/flutter_test.dart';
import 'package:c317_mobile/models/contact.dart';

void main() {
  group('Contact', () {
    late Contact contact;

    setUp(() {
      contact = Contact(
        id: 1,
        area: '123',
        number: '4567890',
      );
    });

    test('should have correct properties', () {
      expect(contact.id, 1);
      expect(contact.area, '123');
      expect(contact.number, '4567890');
    });

    test('should create Contact from json', () {
      final json = {
        'id': 1,
        'area': '123',
        'number': '4567890',
      };
      final contact = Contact.fromJson(json);
      expect(contact.id, 1);
      expect(contact.area, '123');
      expect(contact.number, '4567890');
    });
  });
}
