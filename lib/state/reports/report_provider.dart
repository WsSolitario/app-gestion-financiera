import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../config/locator.dart';
import '../../repositories/reports_repository.dart';
import 'report_state.dart';

final reportNotifierProvider =
    StateNotifierProvider<ReportNotifier, ReportState>((ref) {
  return ReportNotifier(locator<ReportsRepository>());
});

class ReportNotifier extends StateNotifier<ReportState> {
  final ReportsRepository _repo;
  ReportNotifier(this._repo) : super(ReportState.initial());

  Future<void> fetchReports({
    String? groupId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final reports = await _repo.fetchReports(
        groupId: groupId,
        startDate: startDate,
        endDate: endDate,
      );
      state = state.copyWith(reports: reports, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
