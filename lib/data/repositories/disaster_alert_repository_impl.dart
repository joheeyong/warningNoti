import '../../models/disaster_alert.dart';
import '../datasources/disaster_alert_remote_datasource.dart';
import 'disaster_alert_repository.dart';

class DisasterAlertRepositoryImpl implements DisasterAlertRepository {
  final DisasterAlertRemoteDatasource _remoteDatasource;

  DisasterAlertRepositoryImpl(this._remoteDatasource);

  @override
  Future<List<DisasterAlert>> getAlerts({
    int page = 1,
    int pageSize = 20,
  }) async {
    return _remoteDatasource.getDisasterAlerts(
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<List<DisasterAlert>> getAlertsByRegion(String region) async {
    final alerts = await _remoteDatasource.getDisasterAlerts();
    return alerts.where((alert) => alert.region.contains(region)).toList();
  }
}
