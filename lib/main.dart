import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'config/locator.dart';
import 'ui/routes.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/dashboard_screen.dart';
import 'ui/screens/register_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/groups/group_list_screen.dart';
import 'ui/screens/groups/group_detail_view.dart';
import 'ui/screens/groups/group_form_screen.dart';
import 'ui/screens/groups/group_members_screen.dart';
import 'ui/screens/groups/group_balances_screen.dart';
import 'ui/screens/expenses/expense_list_screen.dart';
import 'ui/screens/expenses/expense_detail_screen.dart';
import 'ui/screens/expenses/expense_form_screen.dart';
import 'ui/screens/notifications_screen.dart';
import 'ui/screens/recurring_payments/recurring_payments_screen.dart';
import 'ui/screens/reports/reports_screen.dart';
import 'ui/screens/payments/payment_list_screen.dart';
import 'ui/screens/invitations/invitation_list_screen.dart';
import 'ui/screens/invitations/invitation_accept_screen.dart';
import 'ui/screens/payments/payment_form_screen.dart';
import 'ui/screens/payments/payment_approval_screen.dart';
import 'state/app_mode/app_mode_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);

    if (appMode == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final router = GoRouter(
      initialLocation: AppRoutes.login,
      routes: [
        GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
        GoRoute(
          path: AppRoutes.register,
          builder: (_, state) => RegisterScreen(
            registrationToken: state.uri.queryParameters['registration_token'],
            invitationToken: state.uri.queryParameters['invitation_token'],
          ),
        ),
        GoRoute(
            path: AppRoutes.dashboard,
            builder: (_, __) => const DashboardScreen()),
        GoRoute(
            path: AppRoutes.profile, builder: (_, __) => const ProfileScreen()),
        GoRoute(path: AppRoutes.groups,
            builder: (_, __) => const GroupListScreen()),
        GoRoute(path: AppRoutes.groupForm,
            builder: (_, __) => const GroupFormScreen()),
        GoRoute(
            path: AppRoutes.notifications,
            builder: (_, __) => const NotificationsScreen()),
        GoRoute(
            path: AppRoutes.recurringPayments,
            builder: (_, __) => const RecurringPaymentsScreen()),
        GoRoute(
            path: AppRoutes.reports,
            builder: (_, __) => const ReportsScreen()),
        GoRoute(
            path: AppRoutes.groupDetail,
            builder: (_, __) => const GroupDetailView()),
        GoRoute(
            path: '/groups/:id/members',
            builder: (_, state) =>
                GroupMembersScreen(groupId: state.pathParameters['id']!)),
        GoRoute(
            path: '/groups/:id/balances',
            builder: (_, state) =>
                GroupBalancesScreen(groupId: state.pathParameters['id']!)),
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
        GoRoute(path: AppRoutes.invitations,
            builder: (_, __) => const InvitationListScreen()),
        GoRoute(
            path: AppRoutes.invitationAccept,
            builder: (_, __) => const InvitationAcceptScreen()),
        GoRoute(
            path: AppRoutes.payments,
            builder: (_, state) =>
                PaymentListScreen(groupId: state.pathParameters['id']!)),
        GoRoute(
            path: AppRoutes.paymentForm,
            builder: (_, state) =>
                PaymentFormScreen(groupId: state.pathParameters['id']!)),
        GoRoute(
            path: AppRoutes.paymentDetail,
            builder: (_, state) =>
                PaymentApprovalScreen(id: state.pathParameters['payId']!)),
      ],
      );

      return MaterialApp.router(
        title: 'SSDS App ($appMode)',
        routerConfig: router,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      );
    }
  }
