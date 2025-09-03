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

  Future<User> register(String email, String password,
      {String? name, List<String> tokens = const []}) async {
    final res = await _client.post("/auth/register", data: {
      "email": email,
      "password": password,
      "password_confirmation": password,
      "name": name,
      "tokens": tokens,
    });
    return User.fromJson(res.data["user"]);
  }

  Future<User> updateProfile(
      {String? name,
      String? email,
      String? profilePictureUrl,
      String? phoneNumber}) async {
    final res = await _client.put("/users/me", data: {
      "name": name,
      "email": email,
      "profile_picture_url": profilePictureUrl,
      "phone_number": phoneNumber,
    });
    return User.fromJson(res.data["user"]);
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    await _client.put("/users/me/password", data: {
      "current_password": currentPassword,
      "password": newPassword,
      "password_confirmation": newPassword,
    });
  }
}
