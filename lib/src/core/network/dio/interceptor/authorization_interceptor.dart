import 'package:dio/dio.dart';
import 'package:weather/src/config/config.dart';

class AuthorizationInterceptor extends QueuedInterceptorsWrapper {
  AuthorizationInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.queryParameters.addAll(
      <String, String>{
        'appid': AppStrings.apiKey,
      },
    );

    handler.next(options);
  }
}
