import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../../core/utils/logger.dart';
import '../../models/enums/alert_severity.dart';
import '../../models/weather_warning.dart';

class WeatherWarningRemoteDatasource {
  final Dio _dio;

  WeatherWarningRemoteDatasource(this._dio);

  Future<List<WeatherWarning>> getWeatherWarnings({
    String? region,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'pageNo': page,
        'numOfRows': pageSize,
      };
      if (region != null) {
        queryParams['stnId'] = region;
      }

      final response = await _dio.get(
        ApiConstants.weatherWarningPath,
        queryParameters: queryParams,
      );

      final data = response.data;
      if (data == null) {
        return [];
      }

      final items = _extractItems(data);
      return items.map((item) => _parseWeatherWarning(item)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      Logger.error('기상특보 조회 실패', tag: 'DataSource', error: e);
      throw ParseException(originalError: e);
    }
  }

  List<dynamic> _extractItems(dynamic data) {
    try {
      final body = data['response']?['body'];
      if (body == null) return [];

      final items = body['items']?['item'];
      if (items == null) return [];
      if (items is List) return items;
      return [items];
    } catch (_) {
      return [];
    }
  }

  WeatherWarning _parseWeatherWarning(Map<String, dynamic> json) {
    final title = (json['t6'] as String?) ?? '기상특보';
    final content = (json['t7'] as String?) ?? '';

    return WeatherWarning(
      id: '${json['stnId'] ?? DateTime.now().millisecondsSinceEpoch}',
      title: title,
      content: content,
      severity: _inferSeverity(title),
      region: (json['areaName'] as String?) ?? '전국',
      issuedAt: _parseDate(json['tmFc'] as String?) ?? DateTime.now(),
    );
  }

  AlertSeverity _inferSeverity(String title) {
    if (title.contains('경보')) return AlertSeverity.warning;
    if (title.contains('긴급')) return AlertSeverity.emergency;
    return AlertSeverity.advisory;
  }

  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null) return null;
    try {
      if (dateStr.length == 12) {
        return DateTime(
          int.parse(dateStr.substring(0, 4)),
          int.parse(dateStr.substring(4, 6)),
          int.parse(dateStr.substring(6, 8)),
          int.parse(dateStr.substring(8, 10)),
          int.parse(dateStr.substring(10, 12)),
        );
      }
      return DateTime.parse(dateStr);
    } catch (_) {
      return null;
    }
  }

  AppException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(originalError: e);
      case DioExceptionType.connectionError:
        return NetworkException(originalError: e);
      default:
        return ServerException(
          statusCode: e.response?.statusCode,
          originalError: e,
        );
    }
  }
}
