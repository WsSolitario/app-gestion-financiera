import '../models/group.dart';
import '../services/group_service.dart';

class GroupRepository {
  final GroupService _service;

  GroupRepository(this._service);

  Future<List<Group>> getGroups() async {
    return _service.getGroups();
  }

  Future<Group> getGroup(String id) async {
    return _service.getGroup(id);
  }

  Future<Group> createGroup(String name) async {
    return _service.createGroup(name);
  }

  Future<Group> updateGroup(String id, {required String name}) async {
    return _service.updateGroup(id, name: name);
  }

  Future<void> deleteGroup(String id) async {
    await _service.deleteGroup(id);
  }
}
