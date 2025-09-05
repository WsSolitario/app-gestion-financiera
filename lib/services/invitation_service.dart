import "package:dio/dio.dart";

import "../models/invitation.dart";
import "../services/api_client.dart";

class InvitationService {
  final ApiClient _client;
  InvitationService(this._client);

  /// GET /api/invitations[?mine=true][&group_id=UUID]
  Future<List<Invitation>> getInvitations({bool? mine, String? groupId}) async {
    try {
      final res = await _client.get(
        "/invitations",
        query: {
          if (mine != null) "mine": mine.toString(),
          if (groupId != null) "group_id": groupId,
        },
        queryParameters: <String, dynamic>{},
      );
      final data = res.data as List;
      return data.map((e) => Invitation.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  /// POST /api/invitations
  /// Body: { "invitee_email": "...", "group_id": "UUID", "expires_in_days"?: int }
  /// Respuesta: { "token": "INVITE-TOKEN" } (tu modelo puede mapearlo).
  Future<Invitation> sendInvitation(
    String groupId,
    String inviteeEmail, {
    int? expiresInDays,
  }) async {
    try {
      final res = await _client.post(
        "/invitations",
        data: {
          "invitee_email": inviteeEmail,
          "group_id": groupId,
          if (expiresInDays != null) "expires_in_days": expiresInDays,
        },
      );
      return Invitation.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  /// POST /api/invitations/accept
  /// Body: { "token": "INVITE-TOKEN" }
  Future<void> acceptInvitation(String token) async {
    try {
      await _client.post("/invitations/accept", data: {"token": token});
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
