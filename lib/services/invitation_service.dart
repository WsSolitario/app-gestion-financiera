import "package:dio/dio.dart";

import "../services/api_client.dart";

class InvitationService {
  final ApiClient _client;
  InvitationService(this._client);

  Future<List<dynamic>> getInvitations() async {
    try {
      final res = await _client.get("/invitations");
      return List<dynamic>.from(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> sendInvitation(String groupId, String inviteeEmail) async {
    try {
      await _client.post("/invitations", data: {
        "group_id": groupId,
        "invitee_email": inviteeEmail,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> acceptInvitation(String invitationId) async {
    try {
      await _client.post("/invitations/accept", data: {
        "invitation_id": invitationId,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
