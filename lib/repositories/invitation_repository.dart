import "../models/invitation.dart";
import "../services/invitation_service.dart";

class InvitationRepository {
  final InvitationService _service;
  InvitationRepository(this._service);

  Future<List<Invitation>> fetchInvitations() => _service.getInvitations();

  Future<Invitation> sendInvitation(String groupId, String inviteeEmail) =>
      _service.sendInvitation(groupId, inviteeEmail);

  Future<void> acceptInvitation(String token) =>
      _service.acceptInvitation(token);
}
