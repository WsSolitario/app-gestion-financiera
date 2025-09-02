import '../models/group.dart';
import 'api_client.dart';

class GroupService {
  final ApiClient _client;
  GroupService(this._client);

  Future<List<Group>> getGroups() async {
    final res = await _client.get('/groups');
    final data = res.data as List;
    return data.map((g) => Group.fromJson(g)).toList();
    }

  Future<Group> getGroup(String id) async {
    final res = await _client.get('/groups/$id');
    return Group.fromJson(res.data);
  }

  Future<Group> createGroup(Group group) async {
    final res = await _client.post('/groups', data: group.toJson());
    return Group.fromJson(res.data);
  }

  Future<Group> updateGroup(Group group) async {
    final res = await _client.put('/groups/${group.id}', data: group.toJson());
    return Group.fromJson(res.data);
  }

  Future<void> deleteGroup(String id) => _client.delete('/groups/$id');
}

