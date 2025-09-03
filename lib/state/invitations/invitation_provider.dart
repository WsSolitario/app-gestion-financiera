import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../config/locator.dart';
import '../../repositories/invitation_repository.dart';
import 'invitation_state.dart';

final invitationNotifierProvider =
    StateNotifierProvider<InvitationNotifier, InvitationState>((ref) {
  return InvitationNotifier(locator<InvitationRepository>());
});

class InvitationNotifier extends StateNotifier<InvitationState> {
  final InvitationRepository _repo;
  InvitationNotifier(this._repo) : super(InvitationState.initial());

  Future<void> fetchInvitations() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final invitations = await _repo.fetchInvitations();
      state = state.copyWith(invitations: invitations, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> acceptInvitation(String token) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.acceptInvitation(token);
      final invitations = await _repo.fetchInvitations();
      state = state.copyWith(invitations: invitations, isLoading: false);
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
