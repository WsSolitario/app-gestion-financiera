class Invitation {
  final String id;
  final String groupId;
  final String email;
  final String status;
  final String? invitedBy;
  final DateTime? createdAt;

  Invitation({
    required this.id,
    required this.groupId,
    required this.email,
    required this.status,
    this.invitedBy,
    this.createdAt,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
        id: json['id'].toString(),
        groupId: json['groupId'].toString(),
        email: json['email'] ?? '',
        status: json['status'] ?? '',
        invitedBy: json['invitedBy']?.toString(),
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'email': email,
        'status': status,
        'invitedBy': invitedBy,
        'createdAt': createdAt?.toIso8601String(),
      };
}

