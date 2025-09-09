import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// Custom exception classes
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, {this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status Code: $statusCode)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

// Failure classes for error handling
abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

class ApiService {
  static ApiService? _instance;
  late Dio _dio;
  Dio get dioInstance => _dio;

  static ApiService get instance {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  ApiService._internal() {
    _dio = Dio();
    _setupInterceptors();
  }

  static const String baseUrl =
      'https://api.nytimes.com/svc/topstories/v2/arts.json';

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.baseUrl = baseUrl;
          options.connectTimeout = const Duration(seconds: 30);
          options.receiveTimeout = const Duration(seconds: 30);

          if (kDebugMode) {
            log('🚀 REQUEST[${options.method}] => PATH: ${options.path}');
            log('Headers: ${options.headers}');
            log('Query Parameters: ${options.queryParameters}');
            if (options.data != null) {
              log('Body: ${options.data}');
            }
          }

          handler.next(options);
        },

        onResponse: (Response response, ResponseInterceptorHandler handler) {
          if (kDebugMode) {
            log(
              '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
            );
            log('Data: ${response.data}');
          }

          handler.next(response);
        },

        onError: (DioException error, ErrorInterceptorHandler handler) {
          if (kDebugMode) {
            log(
              '❌ ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
            );
            log('Message: ${error.message}');
            log('Data: ${error.response?.data}');
          }

          handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          error: true,
          logPrint: (obj) => log(obj.toString()),
        ),
      );
    }
  }

  Failure handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
          'Connection timeout. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data?['message'] ??
            error.response?.statusMessage ??
            'Server error occurred';

        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              return ServerFailure(
                'Bad Request: $message',
                statusCode: statusCode,
              );
            case 401:
              return ServerFailure(
                'Unauthorized: Please login again',
                statusCode: statusCode,
              );
            case 403:
              return ServerFailure(
                'Forbidden: Access denied',
                statusCode: statusCode,
              );
            case 404:
              return ServerFailure(
                'Not Found: Resource not found',
                statusCode: statusCode,
              );
            case 500:
              return ServerFailure(
                'Internal Server Error: Please try again later',
                statusCode: statusCode,
              );
            default:
              return ServerFailure(message, statusCode: statusCode);
          }
        }
        return ServerFailure(message, statusCode: statusCode);

      case DioExceptionType.cancel:
        return const NetworkFailure('Request was cancelled');

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          'No internet connection. Please check your network settings.',
        );

      case DioExceptionType.badCertificate:
        return const NetworkFailure('Certificate verification failed');

      default:
        return NetworkFailure(
          'Network error: ${error.message ?? "Unknown error"}',
        );
    }
  }
}
