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

class AuthRegistered extends AuthState {
  final String userEmail;
  const AuthRegistered(this.userEmail);
}

class AuthProfileUpdated extends AuthState {
  final String userEmail;
  const AuthProfileUpdated(this.userEmail);
}

class AuthPasswordUpdated extends AuthState {
  const AuthPasswordUpdated();
}
