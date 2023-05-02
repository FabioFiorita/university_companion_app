import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

import 'logging_interceptor.dart';

class WebClient {
  // static const String baseUrl = 'http://192.168.68.124:8000/api/';
  static const String baseUrl = 'http://192.168.68.124:3000/';

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: const Duration(seconds: 5),
  );
}
