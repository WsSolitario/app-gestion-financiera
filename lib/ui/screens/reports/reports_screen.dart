import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state/reports/report_provider.dart';

class ReportsScreen extends HookConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportNotifierProvider);

    useEffect(() {
      ref.read(reportNotifierProvider.notifier).fetchReports();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : ListView.builder(
                  itemCount: state.reports.length,
                  itemBuilder: (_, index) {
                    final r = state.reports[index];
                    return ListTile(
                      title: Text(r.title),
                      subtitle: Text(r.description),
                    );
                  },
                ),
    );
  }
}
