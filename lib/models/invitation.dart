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
        groupId:
            json['group_id']?.toString() ?? json['groupId'].toString(),
        email: json['email'] ?? '',
        status: json['status'] ?? '',
        invitedBy:
            json['invited_by']?.toString() ?? json['invitedBy']?.toString(),
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : json['createdAt'] != null
                ? DateTime.parse(json['createdAt'])
                : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : json['updatedAt'] != null
                ? DateTime.parse(json['updatedAt'])
                : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'group_id': groupId,
        'email': email,
        'status': status,
        'invited_by': invitedBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

