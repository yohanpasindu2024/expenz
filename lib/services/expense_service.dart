import 'dart:convert';

import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  static final String _key = "expense";

  // SAVE Expense Items as a List converted by json.
  Future<void> saveExpense(
    Expense expense,
    BuildContext context,
  ) async {
    List<Expense> decExpenseList = [];
    List<String> serExpenseList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serExpenseList = prefs.getStringList(_key) ?? [];

      decExpenseList =
          serExpenseList.map((e) => Expense.fromJSON(json.decode(e))).toList();
      decExpenseList.add(expense);
      serExpenseList =
          decExpenseList.map((e) => json.encode(e.toJSON())).toList();
      await prefs.setStringList(_key, serExpenseList);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("The item ${expense.category.name} is succesfully saved"),
          ),
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text("The item ${expense.category.name} saving is failed"),
            ),
          );
        }
      }
    }
  }

  // GET Expense items as Dart List obj.
  Future<List<Expense>?> getExpensesAsList(BuildContext context) async {
    List<Expense> decExpenseList = [];
    List<String> serExpenseList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serExpenseList = prefs.getStringList(_key) ?? [];
      decExpenseList =
          serExpenseList.map((e) => Expense.fromJSON(json.decode(e))).toList();
      return decExpenseList;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("The loading failure"),
            ),
          );
        }
      }
    }
    return [];
  }
}
