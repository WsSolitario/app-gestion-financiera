import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../state/auth/auth_provider.dart";
import "../../state/app_mode_provider.dart";
import "../routes.dart";

class RegisterScreen extends ConsumerStatefulWidget {
  final String? registrationToken;
  final String? invitationToken;

  const RegisterScreen({
    super.key,
    this.registrationToken,
    this.invitationToken,
  });

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _registrationToken = TextEditingController();
  final _invitationToken = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final appMode = ref.watch(appModeProvider);
    final isPrivate = appMode == 'private';

    ref.listen(authNotifierProvider, (prev, next) {
      if (next is AuthRegistered) {
        context.go(AppRoutes.login);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: "Nombre"),
                ),
                const SizedBox(height: 12),
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
                if (isPrivate) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _registrationToken,
                    decoration:
                        const InputDecoration(labelText: "Registration Token"),
                    validator: (v) =>
                        (isPrivate && (v == null || v.isEmpty)) ? "Requerido" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _invitationToken,
                    decoration:
                        const InputDecoration(labelText: "Invitation Token"),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state is! AuthLoading
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(authNotifierProvider.notifier).register(
                                  _email.text.trim(),
                                  _password.text.trim(),
                                  name: _name.text.trim().isEmpty
                                      ? null
                                      : _name.text.trim(),
                                  registrationToken: widget.registrationToken,
                                  invitationToken: widget.invitationToken,
                                  registrationToken:
                                      _registrationToken.text.trim().isEmpty
                                          ? null
                                          : _registrationToken.text.trim(),
                                  invitationToken:
                                      _invitationToken.text.trim().isEmpty
                                          ? null
                                          : _invitationToken.text.trim(),
                                );
                          }
                        }
                      : null,
                  child:
                      Text(state is AuthLoading ? "Registrando..." : "Registrar"),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: const Text("¿Ya tienes cuenta? Inicia sesión"),
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
