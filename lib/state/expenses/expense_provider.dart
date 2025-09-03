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

  Future<void> fetchExpenses(String groupId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final expenses = await _repo.getExpenses(groupId);
      state = state.copyWith(expenses: expenses, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addExpense(
      String groupId, String description, double amount,
      {String? createdBy}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.createExpense(groupId, description, amount,
          createdBy: createdBy);
      final expenses = await _repo.getExpenses(groupId);
      state = state.copyWith(expenses: expenses, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
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
