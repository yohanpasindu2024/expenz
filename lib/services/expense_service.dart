import 'dart:convert';

import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  static final String _expenseKey = "expense";
  List<Expense> _listOfExpenses = [];
  List<String> _updatedList = [];
  int _expenseListItemCount = 0;

  // * SAVE Expense Items as a List converted by json.
  Future<void> saveExpense(
    Expense expense,
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? listFromPrefs = prefs.getStringList(_expenseKey);

      if (listFromPrefs != null) {
        _listOfExpenses =
            listFromPrefs.map((e) => Expense.fromJSON(json.decode(e))).toList();
        _listOfExpenses.add(expense);
        _updatedList =
            _listOfExpenses.map((e) => json.encode(e.toJSON())).toList();
        await prefs.setStringList(_expenseKey, _updatedList);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "The item ${expense.category.name} is succesfully saved"),
            ),
          );
        }
      } else {
        _listOfExpenses.add(expense);
        _updatedList =
            _listOfExpenses.map((e) => json.encode(e.toJSON())).toList();

        await prefs.setStringList(_expenseKey, _updatedList);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "The item ${expense.category.name} is succesfully saved"),
            ),
          );
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("The item saving is failed"),
            ),
          );
        }
      }
    }
  }

  // * GET Expense items as Dart List obj.
  Future<List<Expense>?> getExpensesAsList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _updatedList = prefs.getStringList(_expenseKey) ?? [];
      _listOfExpenses =
          _updatedList.map((e) => Expense.fromJSON(json.decode(e))).toList();
      return _listOfExpenses;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return null;
  }

  // * Get Expense item count available in prefs.
  Future<int> getExpenseItemCount() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _updatedList = prefs.getStringList(_expenseKey) ?? [];
      _listOfExpenses =
          _updatedList.map((e) => Expense.fromJSON(json.decode(e))).toList();
      _expenseListItemCount = _listOfExpenses.length;
      return _expenseListItemCount;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return 0;
  }
}
