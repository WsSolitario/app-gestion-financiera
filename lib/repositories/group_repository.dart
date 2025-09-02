import '../models/group.dart';
import '../services/group_service.dart';

class GroupRepository {
  final GroupService _service;
  GroupRepository(this._service);

  Future<List<Group>> getGroups() => _service.getGroups();

  Future<Group> getGroup(String id) => _service.getGroup(id);

  Future<Group> createGroup(Group group) => _service.createGroup(group);

  Future<Group> updateGroup(Group group) => _service.updateGroup(group);

  Future<void> deleteGroup(String id) => _service.deleteGroup(id);
}

