class Group {
  final String id;
  final String name;
  final String? description;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Group({
    required this.id,
    required this.name,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        description: json['description'],
        createdBy:
            json['created_by']?.toString() ?? json['createdBy']?.toString(),
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
        'name': name,
        'description': description,
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
