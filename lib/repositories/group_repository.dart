import '../models/group.dart';
import '../models/user.dart';
import '../models/expense.dart';
import '../services/group_service.dart';
import 'expense_repository.dart';

class GroupRepository {
  final GroupService _service;
  final ExpenseRepository _expenseRepo;

  GroupRepository(this._service, this._expenseRepo);

  Future<List<Group>> getGroups() async {
    return _service.getGroups();
  }

  Future<Group> getGroup(String id) async {
    return _service.getGroup(id);
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

  Future<List<User>> getMembers(String groupId) async {
    return _service.getMembers(groupId);
  }

  Future<List<Expense>> getExpenses(String groupId) async {
    return _expenseRepo.getExpenses(groupId);
  }

  Future<List<dynamic>> getBalances(String groupId) async {
    return _service.getBalances(groupId);
  }
}
