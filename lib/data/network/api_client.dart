import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/logger.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        queryParameters: {
          'serviceKey': ApiConstants.apiKey,
          'type': 'json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Logger.debug(
            '→ ${options.method} ${options.uri}',
            tag: 'API',
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          Logger.debug(
            '← ${response.statusCode} ${response.requestOptions.uri}',
            tag: 'API',
          );
          handler.next(response);
        },
        onError: (error, handler) {
          Logger.error(
            '✗ ${error.message} ${error.requestOptions.uri}',
            tag: 'API',
            error: error,
          );
          handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
