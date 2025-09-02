import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/locator.dart';
import '../../repositories/group_repository.dart';
import '../../models/group.dart';
import 'group_state.dart';

final groupNotifierProvider =
    StateNotifierProvider<GroupNotifier, GroupState>((ref) {
  return GroupNotifier(locator<GroupRepository>());
});

class GroupNotifier extends StateNotifier<GroupState> {
  final GroupRepository _repo;
  GroupNotifier(this._repo) : super(GroupState.initial());

  Future<void> fetchGroups() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final groups = await _repo.fetchGroups();
      state = state.copyWith(groups: groups, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addGroup(String name) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.addGroup(name);
      final groups = await _repo.fetchGroups();
      state = state.copyWith(groups: groups, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Group? getById(String id) {
    try {
      return state.groups.firstWhere((g) => g.id == id);
    } catch (_) {
      return null;
    }
  }
}
