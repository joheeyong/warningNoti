import 'enums/alert_severity.dart';

class WeatherWarning {
  final String id;
  final String title;
  final String content;
  final AlertSeverity severity;
  final String region;
  final DateTime issuedAt;
  final DateTime? liftedAt;

  const WeatherWarning({
    required this.id,
    required this.title,
    required this.content,
    required this.severity,
    required this.region,
    required this.issuedAt,
    this.liftedAt,
  });

  bool get isActive => liftedAt == null || liftedAt!.isAfter(DateTime.now());

  static List<WeatherWarning> mockWarnings() {
    final now = DateTime.now();
    return [
      WeatherWarning(
        id: 'ww-001',
        title: '강풍주의보',
        content: '서울, 인천, 경기도에 강풍주의보가 발효 중입니다.',
        severity: AlertSeverity.advisory,
        region: '서울특별시',
        issuedAt: now.subtract(const Duration(hours: 4)),
      ),
      WeatherWarning(
        id: 'ww-002',
        title: '호우경보',
        content: '충청남도, 전라북도에 호우경보가 발효 중입니다.',
        severity: AlertSeverity.warning,
        region: '충청남도',
        issuedAt: now.subtract(const Duration(hours: 2)),
      ),
    ];
  }
}
