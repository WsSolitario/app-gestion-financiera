import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseRepository {
  final ExpenseService _service;

  ExpenseRepository(this._service);

  Future<List<Expense>> getExpenses(String groupId) async {
    return _service.getExpenses(groupId);
  }

  Future<Expense> createExpense(
      String groupId, String description, double amount) async {
    return _service.createExpense(groupId, description, amount);
  }

  Future<Expense> updateExpense(String id,
      {String? description, double? amount}) async {
    return _service.updateExpense(id,
        description: description, amount: amount);
  }

  Future<void> deleteExpense(String id) async {
    await _service.deleteExpense(id);
  }
}

