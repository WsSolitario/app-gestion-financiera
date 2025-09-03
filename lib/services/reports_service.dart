import 'package:dio/dio.dart';

import '../models/report.dart';
import '../services/api_client.dart';

class ReportsService {
  final ApiClient _client;
  ReportsService(this._client);

  Future<List<Report>> getReports() async {
    try {
      final res = await _client.get('/reports');
      final data = res.data as List;
      return data.map((e) => Report.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}
