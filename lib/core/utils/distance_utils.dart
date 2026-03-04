import 'dart:math';

class DistanceUtils {
  DistanceUtils._();

  static const double _earthRadiusKm = 6371.0;

  /// 두 좌표 간 거리 계산 (Haversine 공식, km 단위)
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return _earthRadiusKm * c;
  }

  /// 거리를 사용자 표시용 문자열로 변환
  static String formatDistance(double distanceKm) {
    if (distanceKm < 1.0) {
      return '${(distanceKm * 1000).round()}m';
    }
    return '${distanceKm.toStringAsFixed(1)}km';
  }

  /// 주어진 반경(km) 내에 있는지 확인
  static bool isWithinRadius(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
    double radiusKm,
  ) {
    return calculateDistance(lat1, lon1, lat2, lon2) <= radiusKm;
  }

  static double _toRadians(double degrees) => degrees * pi / 180;
}
