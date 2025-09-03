import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../config/locator.dart';
import '../../repositories/expense_repository.dart';
import '../../models/expense.dart';
import 'expense_state.dart';

final expenseNotifierProvider =
    StateNotifierProvider<ExpenseNotifier, ExpenseState>((ref) {
  return ExpenseNotifier(locator<ExpenseRepository>());
});

class ExpenseNotifier extends StateNotifier<ExpenseState> {
  final ExpenseRepository _repo;

  ExpenseNotifier(this._repo) : super(ExpenseState.initial());

  Future<void> fetchExpenses(String groupId,
      {DateTime? startDate, DateTime? endDate}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final expenses = await _repo.getExpenses(
        groupId,
        startDate: startDate,
        endDate: endDate,
      );
      state = state.copyWith(expenses: expenses, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addExpense(
    String groupId,
    String description,
    double totalAmount, {
    DateTime? expenseDate,
    bool hasTicket = false,
    String? ticketImageUrl,
    String? createdBy,
    List<String> participants = const [],
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.createExpense(
        groupId,
        description,
        totalAmount,
        expenseDate: expenseDate,
        hasTicket: hasTicket,
        ticketImageUrl: ticketImageUrl,
        createdBy: createdBy,
        participants: participants,
      );
      final expenses = await _repo.getExpenses(groupId);
      state = state.copyWith(expenses: expenses, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Expense? getById(String id) {
    try {
      return state.expenses.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
