class Payment {
  final String id;
  final String groupId;
  final String fromUserId;
  final String toUserId;
  final double amount;
  final String status;
  final DateTime? createdAt;

  Payment({
    required this.id,
    required this.groupId,
    required this.fromUserId,
    required this.toUserId,
    required this.amount,
    required this.status,
    this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'].toString(),
        groupId: json['groupId'].toString(),
        fromUserId: json['fromUserId'].toString(),
        toUserId: json['toUserId'].toString(),
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        status: json['status'] ?? '',
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'fromUserId': fromUserId,
        'toUserId': toUserId,
        'amount': amount,
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
      };
}

