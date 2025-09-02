import "../services/api_client.dart";
import "../models/user.dart";

class AuthService {
  final ApiClient _client;
  AuthService(this._client);

  Future<User> login(String email, String password) async {
    final res = await _client.post("/auth/login", data: {
      "email": email,
      "password": password,
    });
    return User.fromJson(res.data["user"]);
  }

  Future<void> logout({bool all = false}) =>
      _client.post("/auth/logout", query: {"all": all});

  Future<User> register(String email, String password, {String? name}) async {
    final res = await _client.post("/auth/register", data: {
      "email": email,
      "password": password,
      "name": name,
    });
    return User.fromJson(res.data["user"]);
  }

  Future<User> updateProfile({String? name, String? email}) async {
    final res = await _client.put("/auth/profile", data: {
      "name": name,
      "email": email,
    });
    return User.fromJson(res.data["user"]);
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    await _client.put("/auth/password", data: {
      "current_password": currentPassword,
      "new_password": newPassword,
    });
  }
}
