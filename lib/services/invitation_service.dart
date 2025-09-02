import '../models/invitation.dart';
import 'api_client.dart';

class InvitationService {
  final ApiClient _client;
  InvitationService(this._client);

  Future<List<Invitation>> getInvitations(String groupId) async {
    final res = await _client.get('/groups/$groupId/invitations');
    final data = res.data as List;
    return data.map((i) => Invitation.fromJson(i)).toList();
  }

  Future<Invitation> getInvitation(String id) async {
    final res = await _client.get('/invitations/$id');
    return Invitation.fromJson(res.data);
  }

  Future<Invitation> createInvitation(
      String groupId, Invitation invitation) async {
    final res = await _client.post('/groups/$groupId/invitations',
        data: invitation.toJson());
    return Invitation.fromJson(res.data);
  }

  Future<Invitation> updateInvitation(Invitation invitation) async {
    final res = await _client.put('/invitations/${invitation.id}',
        data: invitation.toJson());
    return Invitation.fromJson(res.data);
  }

  Future<void> deleteInvitation(String id) =>
      _client.delete('/invitations/$id');
}

