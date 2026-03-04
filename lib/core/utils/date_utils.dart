import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static final DateFormat _koreanFull =
      DateFormat('yyyy년 MM월 dd일 HH:mm', 'ko_KR');
  static final DateFormat _koreanDate =
      DateFormat('yyyy년 MM월 dd일', 'ko_KR');
  static final DateFormat _timeOnly = DateFormat('HH:mm');
  static final DateFormat _apiFormat = DateFormat('yyyyMMdd');
  static final DateFormat _apiTimeFormat = DateFormat('HHmm');

  /// 한국어 전체 날짜/시간 포맷 (예: 2026년 03월 03일 14:30)
  static String formatKoreanFull(DateTime dateTime) {
    return _koreanFull.format(dateTime);
  }

  /// 한국어 날짜만 포맷 (예: 2026년 03월 03일)
  static String formatKoreanDate(DateTime dateTime) {
    return _koreanDate.format(dateTime);
  }

  /// 시간만 포맷 (예: 14:30)
  static String formatTimeOnly(DateTime dateTime) {
    return _timeOnly.format(dateTime);
  }

  /// 기상청 API용 날짜 포맷 (예: 20260303)
  static String formatApiDate(DateTime dateTime) {
    return _apiFormat.format(dateTime);
  }

  /// 기상청 API용 시간 포맷 (예: 1430)
  static String formatApiTime(DateTime dateTime) {
    return _apiTimeFormat.format(dateTime);
  }

  /// API 날짜 문자열을 DateTime으로 파싱
  static DateTime? parseApiDateTime(String? date, String? time) {
    if (date == null || date.isEmpty) return null;
    try {
      final t = time ?? '0000';
      return DateTime.parse(
        '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}'
        'T${t.substring(0, 2)}:${t.substring(2, 4)}:00',
      );
    } catch (_) {
      return null;
    }
  }
}
