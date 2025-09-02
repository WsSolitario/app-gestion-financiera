import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseRepository {
  final ExpenseService _service;
  ExpenseRepository(this._service);

  Future<List<Expense>> getExpenses(String groupId) =>
      _service.getExpenses(groupId);

  Future<Expense> getExpense(String groupId, String id) =>
      _service.getExpense(groupId, id);

  Future<Expense> createExpense(String groupId, Expense expense) =>
      _service.createExpense(groupId, expense);

  Future<Expense> updateExpense(String groupId, Expense expense) =>
      _service.updateExpense(groupId, expense);

  Future<void> deleteExpense(String groupId, String id) =>
      _service.deleteExpense(groupId, id);
}

