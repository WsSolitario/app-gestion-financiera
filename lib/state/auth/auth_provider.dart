import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../repositories/auth_repository.dart";
import "../../config/locator.dart";
import "auth_state.dart";

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(locator<AuthRepository>());
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;
  AuthNotifier(this._repo) : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    state = const AuthLoading();
    try {
      final user = await _repo.login(email, password);
      state = AuthAuthenticated(user.email);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> logout() async {
    state = const AuthLoading();
    try {
      await _repo.logout();
      state = const AuthInitial();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}
