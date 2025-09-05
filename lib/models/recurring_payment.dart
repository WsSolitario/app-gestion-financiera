// lib/models/recurring_payment.dart
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

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    final s = v.toString();
    if (s.isEmpty) return null;
    return DateTime.parse(s);
  }

  factory RecurringPayment.fromJson(Map<String, dynamic> json) => RecurringPayment(
        id: json['id'].toString(),
        groupId: (json['group_id'] ?? json['groupId']).toString(),
        description: (json['description'] ?? '') as String,
        amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
        frequency: (json['frequency'] ?? '') as String,
        nextDate: _parseDate(json['next_date'] ?? json['nextDate']),
        createdAt: _parseDate(json['created_at'] ?? json['createdAt']),
        updatedAt: _parseDate(json['updated_at'] ?? json['updatedAt']),
      );

  /// Enviar al backend en snake_case. No mandamos created/updated (los define el servidor).
  Map<String, dynamic> toJson() => {
        'id': id,
        'group_id': groupId,
        'description': description,
        'amount': amount,
        'frequency': frequency,
        if (nextDate != null) 'next_date': nextDate!.toIso8601String(),
      };
}
