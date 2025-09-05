import '../../models/group.dart';
import '../../models/user.dart';

class GroupState {
  final List<Group> groups;
  final Map<String, List<User>> members;
  final Map<String, List<dynamic>> balances;
  final bool isLoading;
  final String? error;

  const GroupState({
    this.groups = const [],
    this.members = const {},
    this.balances = const {},
    this.isLoading = false,
    this.error,
  });

  GroupState copyWith({
    List<Group>? groups,
    Map<String, List<User>>? members,
    Map<String, List<dynamic>>? balances,
    bool? isLoading,
    String? error,
  }) {
    return GroupState(
      groups: groups ?? this.groups,
      members: members ?? this.members,
      balances: balances ?? this.balances,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory GroupState.initial() => const GroupState();
}
