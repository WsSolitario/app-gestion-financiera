import "package:dio/dio.dart";

import "../models/group.dart";
import "../services/api_client.dart";

class GroupService {
  final ApiClient _client;
  GroupService(this._client);

  Future<List<Group>> getGroups() async {
    try {
      final res = await _client.get("/groups");
      final data = res.data as List;
      return data.map((e) {
        if (e is Map<String, dynamic>) {
          if (e['member_count'] == null && e['members'] is List) {
            e['member_count'] = (e['members'] as List).length;
          }
          if (e['expense_count'] == null && e['expenses'] is List) {
            e['expense_count'] = (e['expenses'] as List).length;
          }
        }
        return Group.fromJson(e);
      }).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Group> getGroup(String id) async {
    try {
      final res = await _client.get("/groups/$id");
      final data = res.data;
      if (data is Map<String, dynamic>) {
        if (data['member_count'] == null && data['members'] is List) {
          data['member_count'] = (data['members'] as List).length;
        }
        if (data['expense_count'] == null && data['expenses'] is List) {
          data['expense_count'] = (data['expenses'] as List).length;
        }
        return Group.fromJson(data);
      }
      return Group.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Group> createGroup(String name, {String? description}) async {
    try {
      final res = await _client.post("/groups", data: {
        "name": name,
        if (description != null) "description": description,
      });
      return Group.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Group> updateGroup(String id,
      {required String name, String? description}) async {
    try {
      final res = await _client.put("/groups/$id", data: {
        "name": name,
        if (description != null) "description": description,
      });
      return Group.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> deleteGroup(String id) async {
    try {
      await _client.delete("/groups/$id");
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> addMember(String groupId, String userId, {String? role}) async {
    try {
      await _client.post("/groups/$groupId/members", data: {
        "user_id": userId,
        if (role != null) "role": role,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> updateMemberRole(
      String groupId, String memberId, String role) async {
    try {
      await _client.put("/groups/$groupId/members/$memberId", data: {
        "role": role,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> deleteMember(String groupId, String memberId) async {
    try {
      await _client.delete("/groups/$groupId/members/$memberId");
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<List<dynamic>> getBalances(String groupId) async {
    try {
      final res = await _client.get("/groups/$groupId/balances");
      final data = res.data as List;
      return data;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
