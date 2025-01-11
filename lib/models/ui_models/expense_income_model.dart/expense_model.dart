import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part "expense_model.g.dart";

// * Expense Model class
@JsonSerializable()
class Expense {
  final String id, description;
  @JsonKey(
    toJson: _expenseCategoryToJSON,
    fromJson: _expenseCategoryFromJSON,
  )
  final ExpenseCategories category;
  final double amount;
  final DateTime date;
  final DateTime time;

  factory Expense.fromJSON(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJSON() => _$ExpenseToJson(this);

  Expense({
    required this.id,
    required this.description,
    required this.category,
    required this.amount,
    required this.date,
    required this.time,
  });
}

// * Custom Converters for imagePathMap and colorPathMap

// * Expense category converter
int _expenseCategoryToJSON(ExpenseCategories category) => category.index;

ExpenseCategories _expenseCategoryFromJSON(int index) =>
    ExpenseCategories.values[index];

// * Expense Categories
@JsonEnum()
enum ExpenseCategories {
  shopping,
  subscription,
  foods,
  health,
  transport;
}

// * Expense Image Path Map
final Map<ExpenseCategories, String> expenseImagePathMap = {
  ExpenseCategories.shopping: 'assets/images/shopping.png',
  ExpenseCategories.subscription: 'assets/images/salary.png',
  ExpenseCategories.foods: 'assets/images/food.png',
  ExpenseCategories.health: 'assets/images/shopping.png',
  ExpenseCategories.transport: 'assets/images/transport.png',
};

// * Expense Color Path Map
final Map<ExpenseCategories, Color> expenseColorPathMap = {
  ExpenseCategories.shopping: yYellowColor,
  ExpenseCategories.subscription: yPurpleColor,
  ExpenseCategories.foods: yOrangeColor,
  ExpenseCategories.health: yGreenColor,
  ExpenseCategories.transport: yBlueColor,
};
