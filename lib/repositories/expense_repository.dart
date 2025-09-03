import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseRepository {
  final ExpenseService _service;

  ExpenseRepository(this._service);

  /// Retrieve all expenses for the specified group.
  Future<List<Expense>> getExpenses(
    String groupId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return _service.getExpenses(
      groupId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Create a new expense in the given group.
  Future<Expense> createExpense(
    String groupId,
    String description,
    double totalAmount, {
    DateTime? expenseDate,
    bool hasTicket = false,
    String? ticketImageUrl,
    String? createdBy,
    List<String> participants = const [],
  }) async {
    return _service.createExpense(
      groupId,
      description,
      totalAmount,
      expenseDate: expenseDate,
      hasTicket: hasTicket,
      ticketImageUrl: ticketImageUrl,
      createdBy: createdBy,
      participants: participants,
    );
  }

  /// Update an existing expense within a group.
  Future<Expense> updateExpense(
    String id,
    String groupId, {
    String? description,
    double? totalAmount,
    DateTime? expenseDate,
    bool? hasTicket,
    String? ticketImageUrl,
    List<String>? participants,
  }) async {
    return _service.updateExpense(
      id,
      groupId,
      description: description,
      totalAmount: totalAmount,
      expenseDate: expenseDate,
      hasTicket: hasTicket,
      ticketImageUrl: ticketImageUrl,
      participants: participants,
    );
  }

  /// Remove an expense by its identifier.
  Future<void> deleteExpense(String id) async {
    await _service.deleteExpense(id);
  }
}
