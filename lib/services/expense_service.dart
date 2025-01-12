import 'dart:convert';

import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  static final String _expenseKey = "expense";

  // SAVE Expense Items as a List converted by json.
  Future<void> saveExpense(
    Expense expense,
    BuildContext context,
  ) async {
    List<Expense> listOfExpenses = [];
    List<String> updatedList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> listFromPrefs = prefs.getStringList(_expenseKey) ?? [];

      listOfExpenses =
          listFromPrefs.map((e) => Expense.fromJSON(json.decode(e))).toList();
      listOfExpenses.add(expense);
      updatedList = listOfExpenses.map((e) => json.encode(e.toJSON())).toList();
      await prefs.setStringList(_expenseKey, updatedList);
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
  Future<List<Expense>?> getExpensesAsList() async {
    List<Expense> listOfExpenses = [];
    List<String> updatedList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      updatedList = prefs.getStringList(_expenseKey) ?? [];
      listOfExpenses =
          updatedList.map((e) => Expense.fromJSON(json.decode(e))).toList();
      return listOfExpenses;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return [];
  }
}
