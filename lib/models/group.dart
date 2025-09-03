class Group {
  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;

  Group({required this.id, required this.name, this.description, this.createdAt});

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        description: json['description'],
        createdAt:
            json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'createdAt': createdAt?.toIso8601String(),
      };
}
