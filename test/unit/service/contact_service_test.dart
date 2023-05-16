import 'package:c317_mobile/exceptions/contact_exception.dart';
import 'package:c317_mobile/service/contact_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:c317_mobile/models/contact.dart';

import '../data/mock_json_consts.dart';

void main() {
  group('ContactService', () {
    const baseUrl =
        'https://raw.githubusercontent.com/FabioFiorita/c317_json/main/contacts.json';

    test('getContacts should return a list of contacts', () async {
      final client = MockClient((request) async {
        expect(request.url.toString(), equals(baseUrl));
        return http.Response(MockJsonContact.list, 200);
      });

      final service = ContactService()..client = client;
      final contacts = await service.getContacts();

      expect(contacts, isA<List<Contact>>());
      expect(contacts.length, equals(3));
      expect(contacts[0].area, equals('CRA'));
      expect(contacts[1].number, equals('(35)3391-3922'));
    });

    test(
        'getContacts should throw ContactException.contactNotFound for a non-200 status code',
        () async {
      final client = MockClient((request) async {
        expect(request.url.toString(), equals(baseUrl));
        return http.Response('', 404);
      });

      final service = ContactService()..client = client;
      expect(() => service.getContacts(),
          throwsA(ContactException.contactNotFound));
    });
  });
}
