import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../state/auth/auth_provider.dart";

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _profileFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (prev, next) {
      if (next is AuthProfileUpdated) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Perfil actualizado")));
      } else if (next is AuthPasswordUpdated) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Contraseña actualizada")));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                Form(
                  key: _profileFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _name,
                        decoration: const InputDecoration(labelText: "Nombre"),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(labelText: "Email"),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: state is! AuthLoading
                            ? () {
                                if (_profileFormKey.currentState!.validate()) {
                                  ref
                                      .read(authNotifierProvider.notifier)
                                      .updateProfile(
                                        name: _name.text.trim().isEmpty
                                            ? null
                                            : _name.text.trim(),
                                        email: _email.text.trim().isEmpty
                                            ? null
                                            : _email.text.trim(),
                                      );
                                }
                              }
                            : null,
                        child: Text(state is AuthLoading
                            ? "Actualizando..."
                            : "Actualizar perfil"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Form(
                  key: _passwordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _currentPassword,
                        decoration:
                            const InputDecoration(labelText: "Contraseña actual"),
                        obscureText: true,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? "Requerido" : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _newPassword,
                        decoration:
                            const InputDecoration(labelText: "Nueva contraseña"),
                        obscureText: true,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? "Requerido" : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: state is! AuthLoading
                            ? () {
                                if (_passwordFormKey.currentState!.validate()) {
                                  ref
                                      .read(authNotifierProvider.notifier)
                                      .updatePassword(
                                        _currentPassword.text.trim(),
                                        _newPassword.text.trim(),
                                      );
                                }
                              }
                            : null,
                        child: Text(state is AuthLoading
                            ? "Actualizando..."
                            : "Actualizar contraseña"),
                      ),
                    ],
                  ),
                ),
                if (state is AuthError) ...[
                  const SizedBox(height: 12),
                  Text(state.message, style: const TextStyle(color: Colors.red)),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
