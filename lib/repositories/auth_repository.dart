import "package:shared_preferences/shared_preferences.dart";
import "../services/auth_service.dart";
import "../models/user.dart";

class AuthRepository {
  final AuthService _service;
  AuthRepository(this._service);

  Future<User> login(String email, String password) async {
    final res = await _service.login(email, password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", res["token"] as String);
    return res["user"] as User;
  }

  Future<void> logout({bool all = false}) async {
    await _service.logout(all: all);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  // Singleton de conveniencia si lo deseas:
  static AuthRepository get instance => throw UnimplementedError("Usa GetIt locator<AuthRepository>()");
}
