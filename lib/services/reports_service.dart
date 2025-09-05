import 'package:dio/dio.dart';

import '../models/report.dart';
import '../services/api_client.dart';

class ReportsService {
  final ApiClient _client;
  ReportsService(this._client);

  /// GET /reports[?groupId][&startDate][&endDate]
  Future<List<Report>> getReports({
    String? groupId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final res = await _client.get(
        '/reports',
        query: {
          if (groupId != null) 'groupId': groupId,
          if (startDate != null) 'startDate': startDate.toIso8601String(),
          if (endDate != null) 'endDate': endDate.toIso8601String(),
        },
        queryParameters: <String, dynamic>{},
      );
      final data = res.data as List;
      return data.map((e) => Report.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}
