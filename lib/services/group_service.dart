import "../models/group.dart";
import "../services/api_client.dart";

class GroupService {
  final ApiClient _client;
  GroupService(this._client);

  Future<List<Group>> fetchGroups() async {
    final res = await _client.get<List<dynamic>>("/groups");
    final data = res.data ?? [];
    return data
        .map((g) => Group.fromJson(g as Map<String, dynamic>))
        .toList();
  }

  Future<Group> getGroup(String id) async {
    final res = await _client.get<Map<String, dynamic>>("/groups/$id");
    return Group.fromJson(res.data!);
  }

  Future<Group> addGroup(String name) async {
    final res = await _client.post<Map<String, dynamic>>("/groups",
        data: {"name": name});
    return Group.fromJson(res.data!);
  }
}
