sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final String userEmail;
  const AuthAuthenticated(this.userEmail);
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
