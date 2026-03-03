import 'enums/alert_severity.dart';
import 'enums/alert_type.dart';

class DisasterAlert {
  final String id;
  final AlertType type;
  final AlertSeverity severity;
  final String title;
  final String description;
  final String region;
  final DateTime issuedAt;
  final DateTime? expiresAt;
  final bool isActive;

  const DisasterAlert({
    required this.id,
    required this.type,
    required this.severity,
    required this.title,
    required this.description,
    required this.region,
    required this.issuedAt,
    this.expiresAt,
    this.isActive = true,
  });

  static List<DisasterAlert> mockAlerts() {
    final now = DateTime.now();
    return [
      DisasterAlert(
        id: 'mock-001',
        type: AlertType.heavyRain,
        severity: AlertSeverity.warning,
        title: '호우 경보',
        description: '서울특별시 전역에 호우 경보가 발령되었습니다. 시간당 50mm 이상의 강한 비가 예상됩니다. 저지대 침수와 산사태에 주의하세요.',
        region: '서울특별시',
        issuedAt: now.subtract(const Duration(hours: 1)),
        expiresAt: now.add(const Duration(hours: 6)),
      ),
      DisasterAlert(
        id: 'mock-002',
        type: AlertType.heatWave,
        severity: AlertSeverity.advisory,
        title: '폭염 주의보',
        description: '경기도 일부 지역에 폭염 주의보가 발령되었습니다. 낮 최고기온 33도 이상이 예상됩니다.',
        region: '경기도',
        issuedAt: now.subtract(const Duration(hours: 3)),
        expiresAt: now.add(const Duration(hours: 12)),
      ),
      DisasterAlert(
        id: 'mock-003',
        type: AlertType.earthquake,
        severity: AlertSeverity.emergency,
        title: '지진 긴급 알림',
        description: '경상북도 경주시 인근에서 규모 4.5 지진이 발생했습니다. 여진에 주의하시고 안전한 장소로 대피하세요.',
        region: '경상북도',
        issuedAt: now.subtract(const Duration(minutes: 15)),
      ),
      DisasterAlert(
        id: 'mock-004',
        type: AlertType.heavySnow,
        severity: AlertSeverity.advisory,
        title: '대설 주의보',
        description: '강원특별자치도 산간 지역에 대설 주의보가 발령되었습니다. 5cm 이상의 눈이 예상됩니다.',
        region: '강원특별자치도',
        issuedAt: now.subtract(const Duration(hours: 5)),
        expiresAt: now.add(const Duration(hours: 8)),
      ),
      DisasterAlert(
        id: 'mock-005',
        type: AlertType.yellowDust,
        severity: AlertSeverity.advisory,
        title: '황사 주의보',
        description: '전국 대부분 지역에 황사 주의보가 발령되었습니다. 외출 시 마스크를 착용하세요.',
        region: '서울특별시',
        issuedAt: now.subtract(const Duration(hours: 2)),
        expiresAt: now.add(const Duration(days: 1)),
      ),
    ];
  }
}
