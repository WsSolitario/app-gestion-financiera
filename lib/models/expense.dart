class Expense {
  final String id;
  final String groupId;
  final String description;
  final double amount;

  Expense({
    required this.id,
    required this.groupId,
    required this.description,
    required this.amount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'].toString(),
        groupId: json['groupId'].toString(),
        description: json['description'] ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'description': description,
        'amount': amount,
      };
}
