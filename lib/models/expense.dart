import 'expense_participant.dart';

class Expense {
  final String id;
  final String groupId;
  final String description;
  final double amount;
  final double totalAmount;
  final DateTime? expenseDate;
  final bool hasTicket;
  final String? ticketImageUrl;
  final List<ExpenseParticipant> participants;
  final String? status;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Expense({
    required this.id,
    required this.groupId,
    required this.description,
    this.amount = 0,
    this.totalAmount = 0,
    this.expenseDate,
    this.hasTicket = false,
    this.ticketImageUrl,
    this.participants = const [],
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'].toString(),
        groupId: json['group_id'].toString(),
        description: json['description'] ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
        expenseDate: json['expense_date'] != null
            ? DateTime.parse(json['expense_date'])
            : null,
        hasTicket: json['has_ticket'] ?? false,
        ticketImageUrl: json['ticket_image_url']?.toString(),
        participants: (json['participants'] as List?)
                ?.map((e) => ExpenseParticipant.fromJson(e))
                .toList() ??
            [],
        status: json['status']?.toString(),
        createdBy: json['created_by']?.toString(),
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
        'description': description,
        'amount': amount,
        'total_amount': totalAmount,
        'expense_date': expenseDate?.toIso8601String(),
        'has_ticket': hasTicket,
        'ticket_image_url': ticketImageUrl,
        'participants': participants.map((e) => e.toJson()).toList(),
        'status': status,
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
