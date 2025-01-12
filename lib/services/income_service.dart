import 'dart:convert';

import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  // KEY for income storage
  final String _key = "income";

  // SAVE income item
  Future<void> saveIncomeItem(Income income, BuildContext context) async {
    // DESETIALIZED income List
    List<Income> decIncomeList = [];
    // SERIALIZED income list
    List<String> serIncomeList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serIncomeList = prefs.getStringList(_key) ?? [];
      decIncomeList =
          serIncomeList.map((e) => Income.fromJSON(json.decode(e))).toList();
      decIncomeList.add(income);
      serIncomeList =
          decIncomeList.map((e) => json.encode(e.toJSON())).toList();
      await prefs.setStringList(_key, serIncomeList);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Income item ${income.category.name} saving successed",
            ),
          ),
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Income item ${income.category.name} saving failed",
            ),
          ),
        );
      }
    }
  }

  // GET income items
  Future<List<Income>?> getIncomeItems(BuildContext context) async {
    // DESETIALIZED income List
    List<Income> decIncomeList = [];
    // SERIALIZED income list
    List<String> serIncomeList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serIncomeList = prefs.getStringList(_key) ?? [];
      decIncomeList =
          serIncomeList.map((e) => Income.fromJSON(json.decode(e))).toList();
      return decIncomeList;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Items loding failure",
            ),
          ),
        );
      }
    }

    return [];
  }
}
