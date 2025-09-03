enum PaymentStatus { pending, approved, rejected }

class Payment {
  final String id;
  final String groupId;
  final String fromUserId;
  final String toUserId;
  final double amount;
  final String? note;
  final String? evidenceUrl;
  final String? paymentMethod;
  final PaymentStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Payment({
    required this.id,
    required this.groupId,
    required this.fromUserId,
    required this.toUserId,
    required this.amount,
    this.note,
    this.evidenceUrl,
    this.paymentMethod,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'].toString(),
        groupId: json['groupId'].toString(),
        fromUserId: json['fromUserId'].toString(),
        toUserId: json['toUserId'].toString(),
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        note: json['note']?.toString(),
        evidenceUrl: json['evidenceUrl']?.toString(),
        paymentMethod: json['paymentMethod']?.toString(),
        status: _statusFromString(json['status'] ?? ''),
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
        'fromUserId': fromUserId,
        'toUserId': toUserId,
        'amount': amount,
        if (note != null) 'note': note,
        if (evidenceUrl != null) 'evidenceUrl': evidenceUrl,
        if (paymentMethod != null) 'paymentMethod': paymentMethod,
        'status': status.name,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

PaymentStatus _statusFromString(String value) {
  return PaymentStatus.values.firstWhere(
    (e) => e.name == value,
    orElse: () => PaymentStatus.pending,
  );
}

