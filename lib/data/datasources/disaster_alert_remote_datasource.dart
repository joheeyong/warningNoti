import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../../core/utils/logger.dart';
import '../../models/disaster_alert.dart';
import '../../models/enums/alert_severity.dart';
import '../../models/enums/alert_type.dart';

class DisasterAlertRemoteDatasource {
  final Dio _dio;

  DisasterAlertRemoteDatasource(this._dio);

  Future<List<DisasterAlert>> getDisasterAlerts({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.disasterMsgPath,
        queryParameters: {
          'pageNo': page,
          'numOfRows': pageSize,
        },
      );

      final data = response.data;
      if (data == null) {
        return [];
      }

      final items = _extractItems(data);
      return items.map((item) => _parseDisasterAlert(item)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      Logger.error('재난문자 조회 실패', tag: 'DataSource', error: e);
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

  DisasterAlert _parseDisasterAlert(Map<String, dynamic> json) {
    final msg = (json['msg'] as String?) ?? '';
    final alertType = _inferAlertType(msg);
    final severity = _inferSeverity(msg);

    return DisasterAlert(
      id: '${json['md101_sn'] ?? DateTime.now().millisecondsSinceEpoch}',
      type: alertType,
      severity: severity,
      title: _extractTitle(msg),
      description: msg,
      region: (json['location_name'] as String?) ?? '전국',
      issuedAt: _parseDate(json['create_date'] as String?) ?? DateTime.now(),
    );
  }

  AlertType _inferAlertType(String message) {
    if (message.contains('호우')) return AlertType.heavyRain;
    if (message.contains('태풍')) return AlertType.typhoon;
    if (message.contains('대설')) return AlertType.heavySnow;
    if (message.contains('한파')) return AlertType.coldWave;
    if (message.contains('폭염')) return AlertType.heatWave;
    if (message.contains('지진')) return AlertType.earthquake;
    if (message.contains('쓰나미')) return AlertType.tsunami;
    if (message.contains('황사')) return AlertType.yellowDust;
    if (message.contains('홍수')) return AlertType.flood;
    if (message.contains('산불')) return AlertType.fire;
    if (message.contains('폭풍')) return AlertType.storm;
    if (message.contains('가뭄')) return AlertType.drought;
    if (message.contains('대기오염') || message.contains('미세먼지')) {
      return AlertType.airPollution;
    }
    return AlertType.other;
  }

  AlertSeverity _inferSeverity(String message) {
    if (message.contains('긴급') || message.contains('대피')) {
      return AlertSeverity.emergency;
    }
    if (message.contains('경보')) return AlertSeverity.warning;
    return AlertSeverity.advisory;
  }

  String _extractTitle(String message) {
    if (message.length <= 30) return message;
    final firstSentence = message.split('.').first.split('。').first;
    if (firstSentence.length <= 50) return firstSentence;
    return '${message.substring(0, 30)}...';
  }

  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null) return null;
    try {
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
