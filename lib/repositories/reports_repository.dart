import '../models/report.dart';
import '../services/reports_service.dart';

class ReportsRepository {
  final ReportsService _service;
  ReportsRepository(this._service);

  Future<List<Report>> fetchReports() => _service.getReports();
}
