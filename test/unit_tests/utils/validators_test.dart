import 'package:flutter_test/flutter_test.dart';
import 'package:c317_mobile/utils/validators.dart';

void main() {
  group('Validators', () {
    test('validateEmail should return null for a valid email', () {
      expect(Validators.validateEmail('test@example.com'), isNull);
    });

    test('validateEmail should return an error message for an invalid email',
        () {
      expect(
          Validators.validateEmail('invalid-email'), equals('E-mail inválido'));
    });

    test('validateEmail should return an error message for a null email', () {
      expect(Validators.validateEmail(null), equals('É necessário um e-mail'));
    });

    test('validatePassword should return null for a valid password', () {
      expect(Validators.validatePassword('password123'), isNull);
    });

    test(
        'validatePassword should return an error message for a password with less than 8 characters',
        () {
      expect(Validators.validatePassword('pass'),
          equals('Senha deve ter no mínimo 8 caracteres'));
    });

    test('validatePassword should return an error message for a null password',
        () {
      expect(Validators.validatePassword(null), equals('Senha é necessária'));
    });

    test('validateTextField should return null for a non-empty string', () {
      expect(Validators.validateTextField('test'), isNull);
    });

    test('validateTextField should return an error message for an empty string',
        () {
      expect(Validators.validateTextField(''), equals('Campo obrigatório'));
    });

    test('validateTextField should return an error message for a null value',
        () {
      expect(Validators.validateTextField(null), equals('Campo obrigatório'));
    });
  });
}
