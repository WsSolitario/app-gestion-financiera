import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../state/auth/auth_provider.dart";
import "package:go_router/go_router.dart";

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (prev, next) {
      if (next is AuthAuthenticated) {
        context.go("/dashboard");
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (v) => (v == null || v.isEmpty) ? "Requerido" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (v) => (v == null || v.isEmpty) ? "Requerido" : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state is! AuthLoading
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(authNotifierProvider.notifier).login(
                                  _email.text.trim(),
                                  _password.text.trim(),
                                );
                          }
                        }
                      : null,
                  child: Text(state is AuthLoading ? "Entrando..." : "Entrar"),
                ),
                if (state is AuthError) ...[
                  const SizedBox(height: 12),
                  Text(state.message, style: const TextStyle(color: Colors.red)),
                ]
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
