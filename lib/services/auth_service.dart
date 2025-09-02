import "../services/api_client.dart";
import "../models/user.dart";

class AuthService {
  final ApiClient _client;
  AuthService(this._client);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _client.post("/auth/login", data: {
      "email": email,
      "password": password,
    });
    return {
      "user": User.fromJson(res.data["user"]),
      "token": res.data["token"],
    };
  }

  Future<void> logout({bool all = false}) =>
      _client.post("/auth/logout", query: {"all": all});
}
