import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:velinno_assestment_task/services/api_service.dart';

class ApiProvider {
  final ApiService _apiService = ApiService.instance;

  Future<Either<Failure, Response>> getApi<T>({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
      };

      final response = await _apiService.dioInstance.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: requestHeaders),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return Right(response);
      } else {
        return Left(
          ServerFailure(
            'Server returned status code: ${response.statusCode}',
            statusCode: response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(_apiService.handleDioException(e));
    } catch (e) {
      return Left(UnknownFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}
