import '../../models/disaster_alert.dart';

abstract class DisasterAlertRepository {
  Future<List<DisasterAlert>> getAlerts({int page, int pageSize});
  Future<List<DisasterAlert>> getAlertsByRegion(String region);
}
