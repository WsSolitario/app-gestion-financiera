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
        groupId: json['group_id'].toString(),
        fromUserId: json['from_user_id'].toString(),
        toUserId: json['to_user_id'].toString(),
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        note: json['note']?.toString(),
        evidenceUrl: json['evidence_url']?.toString(),
        paymentMethod: json['payment_method']?.toString(),
        status: _statusFromString(json['status'] ?? ''),
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
        'from_user_id': fromUserId,
        'to_user_id': toUserId,
        'amount': amount,
        if (note != null) 'note': note,
        if (evidenceUrl != null) 'evidence_url': evidenceUrl,
        if (paymentMethod != null) 'payment_method': paymentMethod,
        'status': status.name,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

PaymentStatus _statusFromString(String value) {
  return PaymentStatus.values.firstWhere(
    (e) => e.name == value,
    orElse: () => PaymentStatus.pending,
  );
}

