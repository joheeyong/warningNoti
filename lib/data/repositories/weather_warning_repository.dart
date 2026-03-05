import '../../models/weather_warning.dart';

abstract class WeatherWarningRepository {
  Future<List<WeatherWarning>> getWarnings({int page, int pageSize});
  Future<List<WeatherWarning>> getWarningsByRegion(String region);
}
