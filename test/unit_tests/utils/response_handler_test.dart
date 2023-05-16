import 'package:c317_mobile/exceptions/general_exception.dart';
import 'package:c317_mobile/utils/response_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResponseHandler', () {
    test(
        'handleStatusCode should throw GeneralException.undefined for status code 500',
        () {
      expect(() => ResponseHandler.handleStatusCode(500, null),
          throwsA(GeneralException.undefined));
    });

    test(
        'handleStatusCode should throw GeneralException.tooManyRequests for status code 429',
        () {
      expect(() => ResponseHandler.handleStatusCode(429, null),
          throwsA(GeneralException.tooManyRequests));
    });

    test(
        'handleStatusCode should throw GeneralException.undefined for status code 404 if exception is null',
        () {
      expect(() => ResponseHandler.handleStatusCode(404, null),
          throwsA(GeneralException.undefined));
    });

    test(
        'handleStatusCode should throw the provided exception for status code 404',
        () {
      const exception = GeneralException.undefined;
      expect(() => ResponseHandler.handleStatusCode(404, exception),
          throwsA(exception));
    });

    test('handleStatusCode should not throw for status code 200', () {
      expect(
          () => ResponseHandler.handleStatusCode(200, null), returnsNormally);
    });

    test(
        'handleStatusCode should throw GeneralException.undefined for status code 400',
        () {
      expect(() => ResponseHandler.handleStatusCode(400, null),
          throwsA(GeneralException.undefined));
    });
  });
}
