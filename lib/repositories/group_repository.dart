import '../models/group.dart';
import '../services/group_service.dart';

class GroupRepository {
  final GroupService _service;

  GroupRepository(this._service);

  Future<List<Group>> getGroups() async {
    final groups = await _service.getGroups();
    return groups
        .map((g) => Group(
              id: g.id,
              name: g.name,
              description: g.description,
              createdBy: g.createdBy,
              createdAt: g.createdAt,
              updatedAt: g.updatedAt,
              memberCount: g.memberCount,
              expenseCount: g.expenseCount,
              imageUrl: g.imageUrl,
            ))
        .toList();
  }

  Future<Group> getGroup(String id) async {
    final g = await _service.getGroup(id);
    return Group(
      id: g.id,
      name: g.name,
      description: g.description,
      createdBy: g.createdBy,
      createdAt: g.createdAt,
      updatedAt: g.updatedAt,
      memberCount: g.memberCount,
      expenseCount: g.expenseCount,
      imageUrl: g.imageUrl,
    );
  }

  Future<Group> createGroup(String name, {String? description}) async {
    return _service.createGroup(name, description: description);
  }

  Future<Group> updateGroup(String id, {required String name, String? description}) async {
    return _service.updateGroup(id, name: name, description: description);
  }

  Future<void> deleteGroup(String id) async {
    await _service.deleteGroup(id);
  }

  Future<void> addMember(String groupId, String userId, {String? role}) async {
    await _service.addMember(groupId, userId, role: role);
  }

  Future<void> updateMemberRole(
      String groupId, String memberId, String role) async {
    await _service.updateMemberRole(groupId, memberId, role);
  }

  Future<void> deleteMember(String groupId, String memberId) async {
    await _service.deleteMember(groupId, memberId);
  }

  Future<List<dynamic>> getBalances(String groupId) async {
    return _service.getBalances(groupId);
  }
}
