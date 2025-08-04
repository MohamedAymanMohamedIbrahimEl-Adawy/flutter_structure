import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int retries;
  final int retryDelay;

  RetryInterceptor({
    required this.dio,
    this.retries = 40, // Number of retry attempts
    this.retryDelay = 0, // Delay between retries in milliseconds
  });

  // @override
  // Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
  //AppLog.printValue('insihere');
  //   if(err.response!=null && err.response!.statusCode != 401){
  //   // print('retries >>>'+(retries > 0).toString());
  //   if (shouldRetry(err)) {
  //  AppLog.printValue('insi');
  //     try {
  //       final response = await dio.fetch(err.requestOptions); // Retry the failed request
  //       handler.resolve(response); // Return the successful response
  //       // for (int attempt = 1; attempt <= retries; attempt++) {
  //       //   await Future.delayed(Duration(milliseconds: retryDelay));
  //       //   try {
  //       //     final response = await dio.fetch(err.requestOptions); // Retry the failed request
  //       //     handler.resolve(response); // Return the successful response
  //       //     return;
  //       //   } catch (e) {
  //       //     // If the attempt fails, we continue to retry
  //       //     if (attempt == retries) {
  //       //       // Throw error after max retries
  //       //       handler.next(err);
  //       //     }
  //       //   }
  //       // }
  //     } catch (e) {
  //       // If we exceed retries, pass the original error
  //       handler.next(err);
  //     }
  //   } else {
  //  AppLog.printValueAndTitle('insi'+err.toString());
  //     // If no retry is required, pass the error to the next interceptor
  //     handler.next(err);
  //   }
  //   }
  // }
  //
  // bool shouldRetry(DioException err) {
  //   // Conditions for retry: on connection timeout, response timeout, or network error
  //   return err.type == DioExceptionType.connectionTimeout ||
  //       err.type == DioExceptionType.receiveTimeout ||
  //       err.type == DioExceptionType.sendTimeout || (err.response?.statusCode == 500)||
  //       err.type == DioExceptionType.unknown; // Usually covers no internet
  // }
}
