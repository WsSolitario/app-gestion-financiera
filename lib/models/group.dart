// lib/models/group.dart
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

  factory Group.fromJson(Map<String, dynamic> json) {
    int _toInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is double) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    DateTime? _toDate(dynamic v) {
      if (v == null) return null;
      return DateTime.tryParse(v.toString());
    }

    return Group(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'],
      createdBy: json['created_by']?.toString() ?? json['createdBy']?.toString(),
      imageUrl: json['image_url']?.toString() ?? json['imageUrl']?.toString(),
      memberCount: _toInt(json['member_count'] ?? json['memberCount']),
      expenseCount: _toInt(json['expense_count'] ?? json['expenseCount']),
      createdAt: _toDate(json['created_at'] ?? json['createdAt']),
      updatedAt: _toDate(json['updated_at'] ?? json['updatedAt']),
    );
  }

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
