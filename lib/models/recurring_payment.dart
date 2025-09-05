class RecurringPayment {
  final String id;
  final String groupId;
  final String description;
  final double amount;
  final String frequency;
  final DateTime? nextDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const RecurringPayment({
    required this.id,
    required this.groupId,
    required this.description,
    required this.amount,
    required this.frequency,
    this.nextDate,
    this.createdAt,
    this.updatedAt,
  });

  factory RecurringPayment.fromJson(Map<String, dynamic> json) => RecurringPayment(
        id: json['id'].toString(),
        groupId: json['group_id'].toString(),
        description: json['description'] ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        frequency: json['frequency'] ?? '',
        nextDate: json['next_date'] != null
            ? DateTime.parse(json['next_date'])
            : null,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'group_id': groupId,
        'description': description,
        'amount': amount,
        'frequency': frequency,
        'next_date': nextDate?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
