class User {
  final String id;
  final String email;
  final String? name;
  final String? profilePictureUrl;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    this.name,
    this.profilePictureUrl,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        email: json["email"] ?? "",
        name: json["name"],
        profilePictureUrl: json["profile_picture_url"] ??
            json["avatar_url"] ??
            json["avatarUrl"] ??
            json["profilePictureUrl"],
        phoneNumber: json["phone_number"] ?? json["phoneNumber"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : json["createdAt"] != null
                ? DateTime.parse(json["createdAt"])
                : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : json["updatedAt"] != null
                ? DateTime.parse(json["updatedAt"])
                : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "profile_picture_url": profilePictureUrl,
        "phone_number": phoneNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
