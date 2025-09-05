class RecurringPayment {
  final String id;
  final String groupId;
  final String description;
  final double amount;
  final String frequency;
  final DateTime? nextDate;

  RecurringPayment({
    required this.id,
    required this.groupId,
    required this.description,
    required this.amount,
    required this.frequency,
    this.nextDate,
  });

  factory RecurringPayment.fromJson(Map<String, dynamic> json) => RecurringPayment(
        id: json['id'].toString(),
        groupId:
            json['group_id']?.toString() ?? json['groupId'].toString(),
        description: json['description'] ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        frequency: json['frequency'] ?? '',
        nextDate: json['next_date'] != null
            ? DateTime.parse(json['next_date'])
            : json['nextDate'] != null
                ? DateTime.parse(json['nextDate'])
                : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'group_id': groupId,
        'description': description,
        'amount': amount,
        'frequency': frequency,
        'next_date': nextDate?.toIso8601String(),
      };
}
