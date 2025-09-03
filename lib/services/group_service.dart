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
      return data.map((e) => Group.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Group> getGroup(String id) async {
    try {
      final res = await _client.get("/groups/$id");
      return Group.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Group> createGroup(String name) async {
    try {
      final res = await _client.post("/groups", data: {"name": name});
      return Group.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Group> updateGroup(String id, {required String name}) async {
    try {
      final res = await _client.put("/groups/$id", data: {"name": name});
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
}
