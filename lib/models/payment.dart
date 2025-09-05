// lib/models/payment.dart
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

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    final s = v.toString();
    if (s.isEmpty) return null;
    return DateTime.parse(s);
  }

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'].toString(),
        groupId: (json['group_id'] ?? json['groupId']).toString(),
        fromUserId: (json['from_user_id'] ?? json['fromUserId']).toString(),
        toUserId: (json['to_user_id'] ?? json['toUserId']).toString(),
        amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
        note: json['note']?.toString(),
        evidenceUrl: (json['evidence_url'] ?? json['evidenceUrl'])?.toString(),
        paymentMethod:
            (json['payment_method'] ?? json['paymentMethod'])?.toString(),
        status: _statusFromString(json['status']?.toString() ?? ''),
        createdAt: _parseDate(json['created_at'] ?? json['createdAt']),
        updatedAt: _parseDate(json['updated_at'] ?? json['updatedAt']),
      );

  /// Para enviar al backend (evitamos created/updated al ser del servidor).
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
      };
}

PaymentStatus _statusFromString(String value) {
  return PaymentStatus.values.firstWhere(
    (e) => e.name == value,
    orElse: () => PaymentStatus.pending,
  );
}
