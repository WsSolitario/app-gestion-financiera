
// In-memory repository for managing groups.
import '../models/group.dart';

class GroupRepository {
  final List<Group> _groups = [];

  Future<List<Group>> fetchGroups() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [..._groups];
  }

  Future<Group> getGroup(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _groups.firstWhere((g) => g.id == id);
  }

  Future<Group> addGroup(String name, {String? description}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final now = DateTime.now();
    final group = Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      createdAt: now,
      updatedAt: now,
    );
    _groups.add(group);
    return group;
  }

}
