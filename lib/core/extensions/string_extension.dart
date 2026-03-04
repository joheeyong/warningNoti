extension StringExtension on String {
  /// null이 아니고 공백이 아닌 유효한 문자열인지 확인
  bool get isNotBlank => trim().isNotEmpty;

  /// 최대 길이로 자르고 말줄임표 추가
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  /// 첫 글자를 대문자로 변환
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension NullableStringExtension on String? {
  /// null이거나 빈 문자열인지 확인
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// null이거나 공백만 있는 문자열인지 확인
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
}
