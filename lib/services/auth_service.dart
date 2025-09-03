import "package:dio/dio.dart";

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

  Future<User> register(
    String email,
    String password, {
    String? name,
    String? registrationToken,
    String? invitationToken,
    List<String> tokens = const [],
  }) async {
    try {
      final res = await _client.post("/auth/register", data: {
        "email": email,
        "password": password,
        "password_confirmation": password,
        "name": name,
        "tokens": tokens,
        "registration_token": registrationToken,
        "invitation_token": invitationToken,
      });
      return User.fromJson(res.data["user"]);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data["errors"];
        if (errors is Map) {
          if (errors["registration_token"] != null) {
            final msg = (errors["registration_token"] as List).first;
            throw Exception(msg);
          }
          if (errors["invitation_token"] != null) {
            final msg = (errors["invitation_token"] as List).first;
            throw Exception(msg);
          }
        }
      }
      throw Exception(e.message);
    }
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
