// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  // Key for income storage
  final String _key = "income";

  // Save income item
  Future<void> saveIncomeItem({
    required Income income,
    required void Function(String) message,
  }) async {
    // DESETIALIZED income List
    List<Income> decIncomeList = [];
    // SERIALIZED income list
    List<String> serIncomeList = [];
    try {
      print("${income.category.name} in Income Service");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serIncomeList = prefs.getStringList(_key) ?? [];
      decIncomeList = _desrializeIncomeList(serIncomeList);
      decIncomeList.insert(0, income);
      serIncomeList = _serializeIncomeList(decIncomeList);
      await prefs.setStringList(_key, serIncomeList);
      message("Income item ${income.category.name} saving successed");
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      message("Income item ${income.category.name} saving failed");
    }
  }

  // Get income items
  Future<List<Income>?> getIncomeItems({
    required void Function(String) message,
  }) async {
    // DESETIALIZED income List
    List<Income> decIncomeList = [];
    // SERIALIZED income list
    List<String> serIncomeList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serIncomeList = prefs.getStringList(_key) ?? [];
      decIncomeList = _desrializeIncomeList(serIncomeList);
      return decIncomeList;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      message(error.toString());
    }

    return [];
  }

  // Remove Income item
  Future<void> removeItem({
    required String index,
    required void Function(String) message,
  }) async {
    try {
      // DESETIALIZED income List
      List<Income> decIncomeList = [];
      // SERIALIZED income list
      List<String> serIncomeList = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      serIncomeList = prefs.getStringList(_key) ?? [];
      decIncomeList = _desrializeIncomeList(serIncomeList);
      decIncomeList.removeWhere(
        (element) {
          return element.id == index;
        },
      );
      serIncomeList = _serializeIncomeList(decIncomeList);
      await prefs.setStringList(_key, serIncomeList);
      message("Item deleted");
    } catch (error) {
      print(error.toString());
      message(error.toString());
    }
  }

  Future<void> clearAllIncomes({required void Function(String) message}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (error) {
      if (kDebugMode) print(error.toString());
      message("Income deleting failure");
    }
  }

  List<String> _serializeIncomeList(List<Income> incomeList) {
    return incomeList.map((e) => json.encode(e.toJSON())).toList();
  }

  List<Income> _desrializeIncomeList(List<String> incomeList) {
    return incomeList.map((e) => Income.fromJSON(json.decode(e))).toList();
  }
}
