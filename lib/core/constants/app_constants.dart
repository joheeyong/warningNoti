class AppConstants {
  AppConstants._();

  static const String appName = '재난알리미';
  static const String defaultRegion = '서울특별시';

  static const List<String> regions = [
    '서울특별시',
    '부산광역시',
    '대구광역시',
    '인천광역시',
    '광주광역시',
    '대전광역시',
    '울산광역시',
    '세종특별자치시',
    '경기도',
    '강원특별자치도',
    '충청북도',
    '충청남도',
    '전북특별자치도',
    '전라남도',
    '경상북도',
    '경상남도',
    '제주특별자치도',
  ];

  // SharedPreferences 키
  static const String prefSelectedRegions = 'selected_regions';
  static const String prefNotificationEnabled = 'notification_enabled';
  static const String prefSeverityFilter = 'severity_filter';
}
