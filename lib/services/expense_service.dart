import '../models/expense.dart';
import 'api_client.dart';

class ExpenseService {
  final ApiClient _client;
  ExpenseService(this._client);

  Future<List<Expense>> getExpenses(String groupId) async {
    final res = await _client.get('/groups/$groupId/expenses');
    final data = res.data as List;
    return data.map((e) => Expense.fromJson(e)).toList();
  }

  Future<Expense> getExpense(String groupId, String id) async {
    final res = await _client.get('/groups/$groupId/expenses/$id');
    return Expense.fromJson(res.data);
  }

  Future<Expense> createExpense(String groupId, Expense expense) async {
    final res = await _client.post('/groups/$groupId/expenses',
        data: expense.toJson());
    return Expense.fromJson(res.data);
  }

  Future<Expense> updateExpense(String groupId, Expense expense) async {
    final res = await _client.put(
        '/groups/$groupId/expenses/${expense.id}',
        data: expense.toJson());
    return Expense.fromJson(res.data);
  }

  Future<void> deleteExpense(String groupId, String id) =>
      _client.delete('/groups/$groupId/expenses/$id');
}

