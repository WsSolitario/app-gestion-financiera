import '../../models/group.dart';

class GroupState {
  final List<Group> groups;
  final bool isLoading;
  final String? error;

  const GroupState({
    this.groups = const [],
    this.isLoading = false,
    this.error,
  });

  GroupState copyWith({
    List<Group>? groups,
    bool? isLoading,
    String? error,
  }) {
    return GroupState(
      groups: groups ?? this.groups,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory GroupState.initial() => const GroupState();
}
