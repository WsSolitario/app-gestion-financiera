import '../models/invitation.dart';
import '../services/invitation_service.dart';

class InvitationRepository {
  final InvitationService _service;
  InvitationRepository(this._service);

  Future<List<Invitation>> getInvitations(String groupId) =>
      _service.getInvitations(groupId);

  Future<Invitation> getInvitation(String id) => _service.getInvitation(id);

  Future<Invitation> createInvitation(
          String groupId, Invitation invitation) =>
      _service.createInvitation(groupId, invitation);

  Future<Invitation> updateInvitation(Invitation invitation) =>
      _service.updateInvitation(invitation);

  Future<void> deleteInvitation(String id) => _service.deleteInvitation(id);
}

