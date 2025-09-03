import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseRepository {
  final ExpenseService _service;

  ExpenseRepository(this._service);

  /// Retrieve all expenses for the specified group.
  Future<List<Expense>> getExpenses(String groupId) async {
    return _service.getExpenses(groupId);
  }

  /// Create a new expense in the given group.
  Future<Expense> createExpense(
    String groupId,
    String description,
    double amount, {
    String? createdBy,
  }) async {
    return _service.createExpense(
      groupId,
      description,
      amount,
      createdBy: createdBy,
    );
  }

  /// Update an existing expense within a group.
  Future<Expense> updateExpense(
    String id,
    String groupId, {
    String? description,
    double? amount,
  }) async {
    return _service.updateExpense(
      id,
      groupId,
      description: description,
      amount: amount,
    );
  }

  /// Remove an expense by its identifier.
  Future<void> deleteExpense(String id) async {
    await _service.deleteExpense(id);
  }
}
