class Group {
  final String id;
  final String name;
  final String? description;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;
  final int memberCount;
  final int expenseCount;

  Group({
    required this.id,
    required this.name,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.memberCount = 0,
    this.expenseCount = 0,
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
        imageUrl: json['image_url'] ?? json['imageUrl'],
        memberCount: json['member_count'] != null
            ? int.tryParse(json['member_count'].toString()) ?? 0
            : json['memberCount'] != null
                ? int.tryParse(json['memberCount'].toString()) ?? 0
                : 0,
        expenseCount: json['expense_count'] != null
            ? int.tryParse(json['expense_count'].toString()) ?? 0
            : json['expenseCount'] != null
                ? int.tryParse(json['expenseCount'].toString()) ?? 0
                : 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'image_url': imageUrl,
        'member_count': memberCount,
        'expense_count': expenseCount,
      };
}
