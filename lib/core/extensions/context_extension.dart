import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// 현재 테마
  ThemeData get theme => Theme.of(this);

  /// 현재 컬러 스킴
  ColorScheme get colorScheme => theme.colorScheme;

  /// 텍스트 테마
  TextTheme get textTheme => theme.textTheme;

  /// 화면 크기
  Size get screenSize => MediaQuery.sizeOf(this);

  /// 화면 너비
  double get screenWidth => screenSize.width;

  /// 화면 높이
  double get screenHeight => screenSize.height;

  /// 상단 패딩 (노치 등)
  double get topPadding => MediaQuery.paddingOf(this).top;

  /// 하단 패딩 (홈 인디케이터 등)
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  /// SnackBar 표시
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
