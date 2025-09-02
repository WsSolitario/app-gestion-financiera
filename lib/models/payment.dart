class Payment {
  final String id;
  final String groupId;
  final String fromUserId;
  final String toUserId;
  final double amount;
  final DateTime date;

  Payment({
    required this.id,
    required this.groupId,
    required this.fromUserId,
    required this.toUserId,
    required this.amount,
    required this.date,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'].toString(),
        groupId: json['groupId'].toString(),
        fromUserId: json['fromUserId']?.toString() ?? '',
        toUserId: json['toUserId']?.toString() ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
        date: json['date'] != null
            ? DateTime.parse(json['date'])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'fromUserId': fromUserId,
        'toUserId': toUserId,
        'amount': amount,
        'date': date.toIso8601String(),
      };
}

