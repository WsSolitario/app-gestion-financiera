import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.profile),
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.push(AppRoutes.groups),
          child: const Text('Ver grupos'),
        ),
      ),
    );
  }
}
