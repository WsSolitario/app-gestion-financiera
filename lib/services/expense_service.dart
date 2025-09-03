import "package:dio/dio.dart";

import "../models/expense.dart";
import "../services/api_client.dart";

class ExpenseService {
  final ApiClient _client;
  ExpenseService(this._client);

  Future<List<Expense>> getExpenses(String groupId) async {
    try {
      final res = await _client.get("/groups/$groupId/expenses");
      final data = res.data as List;
      return data.map((e) => Expense.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Expense> createExpense(
      String groupId, String description, double amount) async {
    try {
      final res = await _client.post("/expenses", data: {
        "groupId": groupId,
        "description": description,
        "amount": amount,
      });
      return Expense.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Expense> updateExpense(String id,
      {String? description, double? amount}) async {
    try {
      final res = await _client.put("/expenses/$id", data: {
        if (description != null) "description": description,
        if (amount != null) "amount": amount,
      });
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
