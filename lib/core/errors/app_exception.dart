class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() => 'AppException: $message (statusCode: $statusCode)';
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = '네트워크 연결을 확인해주세요.',
    super.statusCode,
    super.originalError,
  });
}

class ServerException extends AppException {
  const ServerException({
    super.message = '서버 오류가 발생했습니다.',
    super.statusCode,
    super.originalError,
  });
}

class TimeoutException extends AppException {
  const TimeoutException({
    super.message = '요청 시간이 초과되었습니다.',
    super.originalError,
  });
}

class ParseException extends AppException {
  const ParseException({
    super.message = '데이터 파싱 중 오류가 발생했습니다.',
    super.originalError,
  });
}
