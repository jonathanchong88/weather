import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'interceptor/authorization_interceptor.dart';

final dioProvider = Provider<Dio>(
  (ref) => DioBuilder.getInstance(),
);

class DioBuilder extends DioMixin implements Dio {
  // create basic information for request
  final String contentType = 'application/json';
  final int connectionTimeOutMls = 30000;
  final int readTimeOutMls = 30000;
  final int writeTimeOutMls = 30000;

  static DioBuilder getInstance({BaseOptions? options}) =>
      DioBuilder._(options);

  DioBuilder._([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: '',
      contentType: options?.contentType ?? contentType,
      connectTimeout: Duration(milliseconds: connectionTimeOutMls),
      receiveTimeout: Duration(milliseconds: readTimeOutMls),
      sendTimeout: Duration(milliseconds: writeTimeOutMls),
    );

    this.options = options;

    // Config cache
    // final cacheConfig = CacheConfig(baseUrl: Constants.shared().endpoint);
    // interceptors.add(DioCacheManager(cacheConfig).interceptor as InterceptorsWrapper);

    // // token
    // if (isRequestToken && ref != null) {
    interceptors.add(AuthorizationInterceptor());
    // }

    // create default http client
    // If you want run for web, please use httpClientAdapter from BrowserHttpClientAdapter
    // if (kIsWeb) {
    //   httpClientAdapter = BrowserHttpClientAdapter();
    // }
    httpClientAdapter = IOHttpClientAdapter();
  }
}
