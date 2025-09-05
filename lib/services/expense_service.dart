import "package:dio/dio.dart";

import "../models/expense.dart";
import "../models/expense_participant.dart";
import "../services/api_client.dart";

class ExpenseService {
  final ApiClient _client;
  ExpenseService(this._client);

  Future<List<Expense>> getExpenses(
    String groupId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final params = {
        "groupId": groupId,
        if (startDate != null) "startDate": startDate.toIso8601String(),
        if (endDate != null) "endDate": endDate.toIso8601String(),
      };
      final res = await _client.get(
        "/expenses",
        query: params,
      );
      final data = res.data as List;
      return data.map((e) => Expense.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Expense> getExpense(String id) async {
    try {
      final res = await _client.get(
        "/expenses/$id",
      );
      return Expense.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Expense> createExpense(
    String groupId,
    String description,
    double totalAmount, {
    DateTime? expenseDate,
    bool hasTicket = false,
    String? ticketImageUrl,
    String? createdBy,
    List<ExpenseParticipant> participants = const [],
  }) async {
    try {
      final res = await _client.post(
        "/expenses",
        data: {
          "group_id": groupId,
          "description": description,
          "total_amount": totalAmount,
          "expense_date": expenseDate?.toIso8601String(),
          "has_ticket": hasTicket,
          "ticket_image_url": ticketImageUrl,
          "participants": participants.map((p) => p.toJson()).toList(),
          if (createdBy != null) "created_by": createdBy,
        },
      );
      return Expense.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Expense> updateExpense(
    String id,
    String groupId, {
    String? description,
    double? totalAmount,
    DateTime? expenseDate,
    bool? hasTicket,
    String? ticketImageUrl,
    List<ExpenseParticipant>? participants,
  }) async {
    try {
      final data = {
        "group_id": groupId,
        if (description != null) "description": description,
        if (totalAmount != null) "total_amount": totalAmount,
        if (expenseDate != null) "expense_date": expenseDate.toIso8601String(),
        if (hasTicket != null) "has_ticket": hasTicket,
        if (ticketImageUrl != null) "ticket_image_url": ticketImageUrl,
        if (participants != null)
          "participants": participants.map((p) => p.toJson()).toList(),
      };
      final res = await _client.put("/expenses/$id", data: data);
      return Expense.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Expense> approveExpense(String id) async {
    try {
      final res = await _client.post("/expenses/$id/approve");
      return Expense.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await _client.delete("/expenses/$id");
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
