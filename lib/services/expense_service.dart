import "../models/expense.dart";
import "../services/api_client.dart";

class ExpenseService {
  final ApiClient _client;
  ExpenseService(this._client);

  Future<List<Expense>> fetchExpenses(String groupId) async {
    final res =
        await _client.get<List<dynamic>>("/groups/$groupId/expenses");
    final data = res.data ?? [];
    return data
        .map((e) => Expense.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Expense> getExpense(String id) async {
    final res = await _client.get<Map<String, dynamic>>("/expenses/$id");
    return Expense.fromJson(res.data!);
  }

  Future<Expense> addExpense(
      String groupId, String description, double amount) async {
    final res = await _client.post<Map<String, dynamic>>(
      "/groups/$groupId/expenses",
      data: {"description": description, "amount": amount},
    );
    return Expense.fromJson(res.data!);
  }
}
