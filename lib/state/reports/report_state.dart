import '../../models/report.dart';

class ReportState {
  final List<Report> reports;
  final bool isLoading;
  final String? error;

  const ReportState({
    this.reports = const [],
    this.isLoading = false,
    this.error,
  });

  ReportState copyWith({
    List<Report>? reports,
    bool? isLoading,
    String? error,
  }) {
    return ReportState(
      reports: reports ?? this.reports,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory ReportState.initial() => const ReportState();
}
