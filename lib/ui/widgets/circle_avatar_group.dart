import 'package:flutter/material.dart';

const accentColor = Color(0xFFE6E6FA);

class CircleAvatarGroup extends StatelessWidget {
  final List<String> urls;
  final int extraCount;
  const CircleAvatarGroup({super.key, required this.urls, this.extraCount = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          for (int i = 0; i < urls.length; i++)
            Positioned(
              left: i * 28,
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(urls[i]),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: urls.length * 28,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: accentColor,
                child: Text('+$extraCount',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }
}
