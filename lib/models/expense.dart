class Expense {
  final String id;
  final String groupId;
  final String description;
  final double amount;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Expense({
    required this.id,
    required this.groupId,
    required this.description,
    required this.amount,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'].toString(),
        groupId: json['groupId'].toString(),
        description: json['description'] ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        createdBy: json['createdBy']?.toString(),
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
        'description': description,
        'amount': amount,
        'createdBy': createdBy,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
