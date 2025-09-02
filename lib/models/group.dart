class Group {
  final String id;
  final String name;
  final String? description;
  final List<String>? members;

  Group({
    required this.id,
    required this.name,
    this.description,
    this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        description: json['description'],
        members:
            (json['members'] as List?)?.map((m) => m.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'members': members,
      };
}

