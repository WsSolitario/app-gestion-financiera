import '../../models/invitation.dart';

class InvitationState {
  final List<Invitation> invitations;
  final bool isLoading;
  final String? error;

  const InvitationState({
    this.invitations = const [],
    this.isLoading = false,
    this.error,
  });

  InvitationState copyWith({
    List<Invitation>? invitations,
    bool? isLoading,
    String? error,
  }) {
    return InvitationState(
      invitations: invitations ?? this.invitations,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory InvitationState.initial() => const InvitationState();
}
