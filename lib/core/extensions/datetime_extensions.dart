import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toKoreanString() {
    return DateFormat('yyyy년 MM월 dd일 HH:mm', 'ko_KR').format(this);
  }

  String toRelativeString() {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inMinutes < 1) return '방금 전';
    if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';
    if (diff.inDays < 7) return '${diff.inDays}일 전';
    return toKoreanString();
  }

  String toShortString() {
    return DateFormat('MM/dd HH:mm').format(this);
  }
}
