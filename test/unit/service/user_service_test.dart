import 'dart:convert';

import 'package:c317_mobile/exceptions/general_exception.dart';
import 'package:c317_mobile/exceptions/user_exception.dart';
import 'package:c317_mobile/models/user.dart';
import 'package:c317_mobile/service/user_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

import '../data/mock_json_consts.dart';

void main() {
  group('UserService', () {
    late UserService service;

    setUp(() {
      service = UserService()
        ..client = MockClient((request) async {
          if (request.url.toString().contains('login')) {
            return http.Response(MockLogin.token, 200);
          }
          return http.Response('', 404);
        });
    });

    test('login should return a user', () async {
      final result = await service.login('avner@inatel.br', 'password123');

      expect(result, isA<User>());
      expect(result.id, equals(1));
      expect(result.name, equals('Avner'));
      expect(result.email, equals('avner@inatel.br'));
      expect(result.accessToken, equals('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImF2bmVyQGluYXRlbC5iciIsImlkIjoxLCJuYW1lIjoiQXZuZXIiLCJyb2xlIjoic3R1ZGVudCJ9.paH5T8DvAIKfZmU8GaSdAFa95lKTcVb5m0J-KZ8CaXU'));
    });

    test(
        'login should throw UserException.invalidEmail for a 400 status code with "email" in the response body',
        () async {
      service.client = MockClient((request) async {
        if (request.url.toString().contains('login')) {
          return http.Response(MockLogin.error, 401);
        }
        return http.Response('', 404);
      });
      expect(() => service.login('invalidemail', 'password'),
          throwsA(UserException.unauthorized));
    });

    test(
        'login should throw GeneralException.undefined for a non-400 status code',
        () async {
      service.client = MockClient((request) async {
        if (request.url.toString().contains('login')) {
          return http.Response('', 500);
        }
        return http.Response('', 404);
      });
      expect(() => service.login('johndoe@example.com', 'password'),
          throwsA(GeneralException.undefined));
    });
  });
}