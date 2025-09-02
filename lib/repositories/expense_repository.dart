
import '../models/expense.dart';

class ExpenseRepository {
  final List<Expense> _expenses = [];

  Future<List<Expense>> fetchExpenses(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _expenses.where((e) => e.groupId == groupId).toList();
  }

  Future<Expense> getExpense(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _expenses.firstWhere((e) => e.id == id);
  }

  Future<Expense> addExpense(
      String groupId, String description, double amount) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupId: groupId,
      description: description,
      amount: amount,
    );
    _expenses.add(expense);
    return expense;
  }
=======

