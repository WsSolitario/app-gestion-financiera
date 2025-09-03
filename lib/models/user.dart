class User {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;

  User({required this.id, required this.email, this.name, this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        email: json["email"] ?? "",
        name: json["name"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "avatarUrl": avatarUrl,
      };
}
