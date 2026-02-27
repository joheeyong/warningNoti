class ApiConstants {
  ApiConstants._();

  // 공공데이터포털 API
  static const String baseUrl = 'https://apis.data.go.kr';
  static const String disasterMsgPath = '/1741000/DisasterMsg4/getDisasterMsg2List';
  static const String weatherWarningPath = '/1360000/WthrWrnInfoService/getWthrWrnList';

  // 타임아웃 설정
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // API 키 플레이스홀더 (실제 키로 교체 필요)
  static const String apiKey = 'YOUR_API_KEY_HERE';
}
