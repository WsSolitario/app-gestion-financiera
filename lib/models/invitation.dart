class Invitation {
  final String id;
  final String groupId;
  final String email;
  final String status;
  final String? invitedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Invitation({
    required this.id,
    required this.groupId,
    required this.email,
    required this.status,
    this.invitedBy,
    this.createdAt,
    this.updatedAt,
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
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'email': email,
        'status': status,
        'invitedBy': invitedBy,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

