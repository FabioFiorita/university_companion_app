import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  final logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.v("Request to: ${data.baseUrl}\n${data.headers}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode ~/ 100 == 2) {
      logger.i(
          "Response of ${data.url}\n${data.headers}\n${data.statusCode}\n ${data.body}");
    } else {
      logger.e(
          "Response of ${data.url}\n${data.headers}\n${data.statusCode}\n ${data.body}");
    }
    return data;
  }
}
