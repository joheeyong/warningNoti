import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/disaster_alert_remote_datasource.dart';
import '../data/datasources/weather_warning_remote_datasource.dart';
import '../data/repositories/disaster_alert_repository.dart';
import '../data/repositories/disaster_alert_repository_impl.dart';
import '../data/repositories/weather_warning_repository.dart';
import '../data/repositories/weather_warning_repository_impl.dart';
import 'dio_provider.dart';

final disasterAlertDatasourceProvider =
    Provider<DisasterAlertRemoteDatasource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DisasterAlertRemoteDatasource(apiClient.dio);
});

final weatherWarningDatasourceProvider =
    Provider<WeatherWarningRemoteDatasource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return WeatherWarningRemoteDatasource(apiClient.dio);
});

final disasterAlertRepositoryProvider =
    Provider<DisasterAlertRepository>((ref) {
  final datasource = ref.watch(disasterAlertDatasourceProvider);
  return DisasterAlertRepositoryImpl(datasource);
});

final weatherWarningRepositoryProvider =
    Provider<WeatherWarningRepository>((ref) {
  final datasource = ref.watch(weatherWarningDatasourceProvider);
  return WeatherWarningRepositoryImpl(datasource);
});
