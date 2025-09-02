class Expense {
  final String id;
  final String groupId;
  final String description;
  final double amount;
  final String paidBy;
  final DateTime date;

  Expense({
    required this.id,
    required this.groupId,
    required this.description,
    required this.amount,
    required this.paidBy,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'].toString(),
        groupId: json['groupId'].toString(),
        description: json['description'] ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
        paidBy: json['paidBy']?.toString() ?? '',
        date: json['date'] != null
            ? DateTime.parse(json['date'])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'description': description,
        'amount': amount,
        'paidBy': paidBy,
        'date': date.toIso8601String(),
      };
}

