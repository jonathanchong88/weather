import 'package:dio/dio.dart';
import 'package:weather/src/config/config.dart';

extension NetworkHandler on DioException {
  String handleFailure() {
    String message = '';
    switch (type) {
      case DioExceptionType.cancel:
        message = AppStrings.cancelRequest;
        break;
      case DioExceptionType.connectionTimeout:
        message = AppStrings.connectionTimeOut;
        break;
      case DioExceptionType.receiveTimeout:
        message = AppStrings.receiveTimeOut;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          response?.statusCode,
          response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = AppStrings.sendTimeOut;
        break;
      case DioExceptionType.connectionError:
        message = AppStrings.socketException;
        break;
      default:
        message = AppStrings.unknownError;
        break;
    }
    return message;
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return AppStrings.badRequest;
      case 401:
        return AppStrings.unauthorized;
      case 403:
        return AppStrings.forbidden;
      case 404:
        return error['message'];
      case 422:
        return AppStrings.duplicateEmail;
      case 500:
        return AppStrings.internalServerError;
      case 502:
        return AppStrings.badGateway;
      default:
        return AppStrings.unknownError;
    }
  }
}
