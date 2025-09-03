import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
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
      final groups = await _repo.getGroups();
      state = state.copyWith(groups: groups, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addGroup(String name, {String? description}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.createGroup(name, description: description);
      final groups = await _repo.getGroups();
      state = state.copyWith(groups: groups, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateGroup(String id, String name, {String? description}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.updateGroup(id, name: name, description: description);
      final groups = await _repo.getGroups();
      state = state.copyWith(groups: groups, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addMember(String groupId, String userId, {String? role}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.addMember(groupId, userId, role: role);
      final groups = await _repo.getGroups();
      state = state.copyWith(groups: groups, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateMemberRole(
      String groupId, String memberId, String role) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.updateMemberRole(groupId, memberId, role);
      final groups = await _repo.getGroups();
      state = state.copyWith(groups: groups, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteMember(String groupId, String memberId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.deleteMember(groupId, memberId);
      final groups = await _repo.getGroups();
      state = state.copyWith(groups: groups, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<List<dynamic>> getBalances(String groupId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final balances = await _repo.getBalances(groupId);
      state = state.copyWith(isLoading: false);
      return balances;
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
      return [];
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return [];
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
