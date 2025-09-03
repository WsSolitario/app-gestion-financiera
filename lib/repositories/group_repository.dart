
import '../models/group.dart';
import '../services/group_service.dart';

class GroupRepository {
  final GroupService _service;
  GroupRepository(this._service);

  Future<List<Group>> fetchGroups() => _service.fetchGroups();

  Future<Group> getGroup(String id) => _service.getGroup(id);

  Future<Group> addGroup(String name) => _service.addGroup(name);
}
