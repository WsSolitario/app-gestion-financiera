
import '../models/group.dart';
import '../services/group_service.dart';

class GroupRepository {
  final GroupService _service;
  GroupRepository(this._service);

  Future<List<Group>> fetchGroups() => _service.getGroups();

  Future<Group> getGroup(String id) => _service.getGroup(id);

  Future<Group> addGroup(String name) => _service.createGroup(name);

  Future<Group> updateGroup(String id, {required String name}) =>
      _service.updateGroup(id, name: name);

  Future<void> deleteGroup(String id) => _service.deleteGroup(id);
}
