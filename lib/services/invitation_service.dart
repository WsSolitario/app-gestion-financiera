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

  Future<void> sendInvitation(String groupId, String email) async {
    try {
      await _client.post("/invitations", data: {
        "groupId": groupId,
        "email": email,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> respondInvitation(String id, bool accept) async {
    try {
      await _client.post("/invitations/$id/respond", data: {
        "accept": accept,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
