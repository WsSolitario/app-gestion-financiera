import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseRepository {
  final ExpenseService _service;
  ExpenseRepository(this._service);

  Future<List<Expense>> fetchExpenses(String groupId) async {
    return _service.getExpenses(groupId);
  }

  Future<Expense> addExpense(
      String groupId, String description, double amount,
      {String? createdBy}) async {
    return _service.createExpense(groupId, description, amount,
        createdBy: createdBy);
  }

  Future<Expense> updateExpense(String id, String groupId,
      {String? description, double? amount}) async {
    return _service.updateExpense(id, groupId,
        description: description, amount: amount);
  }
}

