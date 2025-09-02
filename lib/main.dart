import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'config/locator.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      initialLocation: "/login",
      routes: [
        GoRoute(path: "/login", builder: (_, __) => const LoginScreen()),
        GoRoute(path: "/dashboard", builder: (_, __) => const DashboardScreen()),
      ],
    );

    return MaterialApp.router(
      title: "SSDS App",
      routerConfig: _router,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    );
  }
}
