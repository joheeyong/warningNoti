import '../../models/weather_warning.dart';
import '../datasources/weather_warning_remote_datasource.dart';
import 'weather_warning_repository.dart';

class WeatherWarningRepositoryImpl implements WeatherWarningRepository {
  final WeatherWarningRemoteDatasource _remoteDatasource;

  WeatherWarningRepositoryImpl(this._remoteDatasource);

  @override
  Future<List<WeatherWarning>> getWarnings({
    int page = 1,
    int pageSize = 20,
  }) async {
    return _remoteDatasource.getWeatherWarnings(
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<List<WeatherWarning>> getWarningsByRegion(String region) async {
    return _remoteDatasource.getWeatherWarnings(region: region);
  }
}
