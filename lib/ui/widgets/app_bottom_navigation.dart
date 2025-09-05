import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes.dart';

/// Bottom navigation bar used across main pages.
class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  const AppBottomNavigation({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.groups);
        break;
      case 1:
        context.go(AppRoutes.dashboard);
        break;
      case 2:
        context.go(AppRoutes.recurringPayments);
        break;
      case 3:
        context.go(AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => _onItemTapped(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Grupos'),
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Pagos'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}
