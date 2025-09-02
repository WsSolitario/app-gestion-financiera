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
}
