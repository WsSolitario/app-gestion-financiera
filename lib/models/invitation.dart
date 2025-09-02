class Invitation {
  final String id;
  final String groupId;
  final String email;
  final String status;

  Invitation({
    required this.id,
    required this.groupId,
    required this.email,
    required this.status,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
        id: json['id'].toString(),
        groupId: json['groupId'].toString(),
        email: json['email'] ?? '',
        status: json['status'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'email': email,
        'status': status,
      };
}

