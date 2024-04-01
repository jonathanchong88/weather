import 'package:dio/dio.dart';
import 'package:weather/src/core/network/dio/dio_builder.dart';

import 'rest_client.dart';
import 'rest_client_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider =
    Provider<RestClientDio>((ref) => RestClientDio(ref.watch(dioProvider)));

class RestClientDio implements RestClient {
  late Dio _dio;

  RestClientDio(Dio dioBuilder) {
    _dio = dioBuilder;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(
    String baseUrl,
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String baseUrl,
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      String url = baseUrl + path;

      final response = await _dio.get<T>(
        url,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
    String baseUrl,
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String baseUrl,
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(
    String baseUrl,
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String baseUrl,
    String path, {
    required String method,
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );
      return _dioConverter<T>(response);
    } on DioException {
      rethrow;
    }
  }

  RestClientResponse<T> _dioConverter<T>(Response<T> response) {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }
}
