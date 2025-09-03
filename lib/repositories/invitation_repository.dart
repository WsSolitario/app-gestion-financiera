import "../services/invitation_service.dart";

class InvitationRepository {
  final InvitationService _service;
  InvitationRepository(this._service);

  Future<List<dynamic>> fetchInvitations() => _service.getInvitations();

  Future<void> sendInvitation(String groupId, String inviteeEmail) =>
      _service.sendInvitation(groupId, inviteeEmail);

  Future<void> acceptInvitation(String invitationId) =>
      _service.acceptInvitation(invitationId);
}
