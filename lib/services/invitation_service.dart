import "package:dio/dio.dart";

import "../models/invitation.dart";
import "../services/api_client.dart";

class InvitationService {
  final ApiClient _client;
  InvitationService(this._client);

  Future<List<Invitation>> getInvitations() async {
    try {
      final res = await _client.get("/invitations");
      final data = res.data as List;
      return data.map((e) => Invitation.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Invitation> sendInvitation(String groupId, String email) async {
    try {
      final res = await _client.post("/invitations", data: {
        "groupId": groupId,
        "email": email,
      });
      return Invitation.fromJson(res.data);
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
