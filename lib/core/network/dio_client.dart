import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: ApiConstants.headers,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}');
        return handler.next(e);
      },
    ));
  }
}