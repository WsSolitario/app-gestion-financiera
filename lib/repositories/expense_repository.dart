import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseRepository {
  final ExpenseService _service;
  ExpenseRepository(this._service);

  Future<List<Expense>> fetchExpenses(String groupId) =>
      _service.fetchExpenses(groupId);

  Future<Expense> getExpense(String id) => _service.getExpense(id);

  Future<Expense> addExpense(
          String groupId, String description, double amount) =>
      _service.addExpense(groupId, description, amount);
}
