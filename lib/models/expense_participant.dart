class ExpenseParticipant {
  final String userId;
  final double amountDue;

  const ExpenseParticipant({
    required this.userId,
    required this.amountDue,
  });

  factory ExpenseParticipant.fromJson(Map<String, dynamic> json) =>
      ExpenseParticipant(
        userId: json['user_id'].toString(),
        amountDue: (json['amount_due'] as num?)?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'amount_due': amountDue,
      };
}

