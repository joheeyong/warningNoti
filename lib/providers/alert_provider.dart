import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/errors/app_exception.dart';
import '../core/utils/logger.dart';
import '../models/disaster_alert.dart';
import '../models/weather_warning.dart';
import 'repository_providers.dart';

final disasterAlertsProvider =
    AsyncNotifierProvider<DisasterAlertsNotifier, List<DisasterAlert>>(
  DisasterAlertsNotifier.new,
);

class DisasterAlertsNotifier extends AsyncNotifier<List<DisasterAlert>> {
  @override
  Future<List<DisasterAlert>> build() async {
    return _fetchAlerts();
  }

  Future<List<DisasterAlert>> _fetchAlerts() async {
    try {
      final repository = ref.read(disasterAlertRepositoryProvider);
      return await repository.getAlerts();
    } on AppException catch (e) {
      Logger.error('재난문자 로드 실패: ${e.message}', tag: 'Provider');
      // API 키가 없거나 네트워크 오류 시 mock 데이터 반환
      return DisasterAlert.mockAlerts();
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchAlerts());
  }

  Future<void> filterByRegion(String region) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(disasterAlertRepositoryProvider);
      final alerts = await repository.getAlertsByRegion(region);
      state = AsyncData(alerts);
    } on AppException {
      final mockAlerts = DisasterAlert.mockAlerts()
          .where((a) => a.region.contains(region))
          .toList();
      state = AsyncData(mockAlerts);
    }
  }
}

final weatherWarningsProvider =
    AsyncNotifierProvider<WeatherWarningsNotifier, List<WeatherWarning>>(
  WeatherWarningsNotifier.new,
);

class WeatherWarningsNotifier extends AsyncNotifier<List<WeatherWarning>> {
  @override
  Future<List<WeatherWarning>> build() async {
    return _fetchWarnings();
  }

  Future<List<WeatherWarning>> _fetchWarnings() async {
    try {
      final repository = ref.read(weatherWarningRepositoryProvider);
      return await repository.getWarnings();
    } on AppException catch (e) {
      Logger.error('기상특보 로드 실패: ${e.message}', tag: 'Provider');
      return WeatherWarning.mockWarnings();
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchWarnings());
  }
}
