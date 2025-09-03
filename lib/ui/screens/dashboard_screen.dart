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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/groups'),
              child: const Text('Ver grupos'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.push('/notifications'),
              child: const Text('Notificaciones'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.push('/recurring-payments'),
              child: const Text('Pagos recurrentes'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.push('/reports'),
              child: const Text('Reportes'),
            ),
          ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/invitations'),
              child: const Text('Ver invitaciones'),
            ),
          ],
        child: ElevatedButton(
          onPressed: () => context.push(AppRoutes.groups),
          child: const Text('Ver grupos'),
        ),
      ),
    );
  }
}
