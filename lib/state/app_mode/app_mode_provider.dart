import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/locator.dart';
import '../../repositories/app_mode_repository.dart';

final appModeProvider =
    StateNotifierProvider<AppModeNotifier, String?>((ref) {
  final notifier = AppModeNotifier(locator<AppModeRepository>());
  notifier.load();
  return notifier;
});

class AppModeNotifier extends StateNotifier<String?> {
  final AppModeRepository _repo;
  AppModeNotifier(this._repo) : super(null);

  Future<void> load() async {
    final mode = await _repo.getAppMode();
    state = mode;
  }
}
