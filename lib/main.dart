import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'config/locator.dart';
import 'ui/routes.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/dashboard_screen.dart';
import 'ui/screens/groups/group_list_screen.dart';
import 'ui/screens/groups/group_detail_screen.dart';
import 'ui/screens/groups/group_form_screen.dart';
import 'ui/screens/expenses/expense_list_screen.dart';
import 'ui/screens/expenses/expense_detail_screen.dart';
import 'ui/screens/expenses/expense_form_screen.dart';
import 'ui/screens/payments/payment_list_screen.dart';
import 'ui/screens/invitations/invitation_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: AppRoutes.login,
      routes: [
        GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
        GoRoute(
            path: AppRoutes.dashboard,
            builder: (_, __) => const DashboardScreen()),
        GoRoute(path: AppRoutes.groups,
            builder: (_, __) => const GroupListScreen()),
        GoRoute(path: AppRoutes.groupForm,
            builder: (_, __) => const GroupFormScreen()),
        GoRoute(
            path: '/groups/:id',
            builder: (_, state) =>
                GroupDetailScreen(id: state.pathParameters['id']!)),
        GoRoute(
            path: '/groups/:id/expenses',
            builder: (_, state) =>
                ExpenseListScreen(groupId: state.pathParameters['id']!)),
        GoRoute(
            path: '/groups/:id/expenses/new',
            builder: (_, state) =>
                ExpenseFormScreen(groupId: state.pathParameters['id']!)),
        GoRoute(
            path: '/groups/:id/expenses/:expId',
            builder: (_, state) =>
                ExpenseDetailScreen(id: state.pathParameters['expId']!)),
        GoRoute(
            path: '/groups/:id/payments',
            builder: (_, state) =>
                PaymentListScreen(groupId: state.pathParameters['id']!)),
        GoRoute(
            path: '/invitations',
            builder: (_, __) => const InvitationListScreen()),
      ],
    );

    return MaterialApp.router(
      title: 'SSDS App',
      routerConfig: router,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    );
  }
}
