import '../exceptions/general_exception.dart';

class ResponseHandler {
  static void handleStatusCode(int statusCode, Exception? exception) {
    switch (statusCode) {
      case 200:
        // success
        break;
      case 400:
        throw GeneralException.undefined;
      case 401:
        throw exception ?? GeneralException.undefined;
      case 404:
        throw exception ?? GeneralException.undefined;
      case 429:
        throw GeneralException.tooManyRequests;
      default:
        throw GeneralException.undefined;
    }
  }
}
