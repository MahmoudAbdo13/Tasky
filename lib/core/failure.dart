import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection time out with server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send time out with server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive time out with server');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate, unauthorized');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request was canceled, Please try later!');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error, Check your connection');
      case DioExceptionType.unknown:
        return ServerFailure('Oops!!, There is an error');
      default:
        return ServerFailure('Unexpected error, Please try again!');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response.toString());
    } else if (statusCode == 404) {
      return ServerFailure('Request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error, Please try later!');
    } else {
      return ServerFailure('Oops! There is an error , please try again!');
    }
  }
}