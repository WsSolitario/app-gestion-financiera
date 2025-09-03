import '../models/expense.dart';
import '../services/expense_service.dart';

/// Provides an abstraction over [ExpenseService] for fetching and
/// mutating expense data.
class ExpenseRepository {
  final ExpenseService _service;
  ExpenseRepository(this._service);

  Future<List<Expense>> fetchExpenses(String groupId) =>
      _service.getExpenses(groupId);

  Future<Expense> getExpense(String id) => _service.getExpense(id);

  Future<Expense> addExpense(
          String groupId, String description, double amount) =>
      _service.createExpense(groupId, description, amount);

  Future<Expense> updateExpense(String id,
          {String? description, double? amount}) =>
      _service.updateExpense(id, description: description, amount: amount);

  Future<void> deleteExpense(String id) => _service.deleteExpense(id);
}
