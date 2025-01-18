import 'dart:convert';

import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  static final String _key = "expense";

  // Save Expense Items as a List converted by json.
  Future<void> saveExpense({
    required Expense expense,
    required void Function(String) message,
  }) async {
    List<Expense> decExpenseList = [];
    List<String> serExpenseList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serExpenseList = prefs.getStringList(_key) ?? [];

      decExpenseList = _deserializeList(serExpenseList);
      decExpenseList.insert(0, expense);
      serExpenseList = _serializeExpenseList(decExpenseList);
      await prefs.setStringList(_key, serExpenseList);
      message("The item ${expense.category.name} is succesfully saved");
    } catch (error) {
      message("The item ${expense.category.name} saving is failed");
    }
  }

  // Get Expense items as Dart List obj.
  Future<List<Expense>?> getExpensesAsList({
    required void Function(String) message,
  }) async {
    List<Expense> decExpenseList = [];
    List<String> serExpenseList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serExpenseList = prefs.getStringList(_key) ?? [];
      decExpenseList = _deserializeList(serExpenseList);
      return decExpenseList;
    } catch (error) {
      message("The loading failure");
    }
    return [];
  }

  // Remove item
  Future<void> removeExpenseItem({
    required String index,
    required void Function(String) message,
  }) async {
    try {
      List<Expense> decExpenseList = [];
      List<String> serExpenseList = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serExpenseList = prefs.getStringList(_key) ?? [];
      decExpenseList = _deserializeList(serExpenseList);
      decExpenseList.removeWhere(
        (element) {
          return element.id == index;
        },
      );
      serExpenseList = _serializeExpenseList(decExpenseList);
      await prefs.setStringList(_key, serExpenseList);
      message("Item deleted");
    } catch (error) {
      message("Item deleting failed");
    }
  }

  Future<void> clearAllExpenses({
    required void Function(String) message,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (error) {
      if (kDebugMode) print(error.toString());
      message("Expense items deleting failure");
    }
  }

  List<Expense> _deserializeList(List<String> list) {
    return list
        .map(
          (e) => Expense.fromJSON(json.decode(e)),
        )
        .toList();
  }

  List<String> _serializeExpenseList(List<Expense> list) {
    return list
        .map(
          (e) => json.encode(e.toJSON()),
        )
        .toList();
  }
}
