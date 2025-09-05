import 'package:flutter/material.dart';
import '../../models/user.dart';

class CircleAvatarGroup extends StatelessWidget {
  final List<User> users;
  final int maxVisible;
  const CircleAvatarGroup({super.key, required this.users, this.maxVisible = 3});

  @override
  Widget build(BuildContext context) {
    final visible = users.take(maxVisible).toList();
    final extraCount = users.length - visible.length;
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: i * 28,
              child: CircleAvatar(
                radius: 24,
                backgroundImage: visible[i].profilePictureUrl != null
                    ? NetworkImage(visible[i].profilePictureUrl!)
                    : null,
                child: visible[i].profilePictureUrl == null
                    ? _buildFallback(visible[i])
                    : null,
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: visible.length * 28,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                child: Text('+${extraCount}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFallback(User user) {
    if (user.name != null && user.name!.isNotEmpty) {
      final parts = user.name!.trim().split(' ');
      String initials = parts.isNotEmpty ? parts[0][0] : '';
      if (parts.length > 1) {
        initials += parts[1][0];
      }
      return Text(initials.toUpperCase());
    }
    if (user.email.isNotEmpty) {
      return Text(user.email[0].toUpperCase());
    }
    return const Icon(Icons.person);
  }
}
