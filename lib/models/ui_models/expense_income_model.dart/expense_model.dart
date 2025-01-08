import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/parent_expense_income_model.dart';
import 'package:flutter/material.dart';

class ExpenseModel extends ParentExpenseIncomeModel {
  ExpenseModel({
    required super.id,
    required super.imagePathMap,
    required super.colorPathMap,
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.time,
  });

  factory ExpenseModel.create({
    required String id,
    required ExpenseCategories category,
    required String description,
    required double amount,
    required DateTime date,
    required DateTime time,
    required PathMapParent<ExpenseCategories, String> imagePathMap,
    required PathMapParent<ExpenseCategories, Color> colorPathMap,
  }) {
    return ExpenseModel(
      id: id,
      category: category,
      description: description,
      amount: amount,
      date: date,
      time: time,
      imagePathMap: imagePathMap,
      colorPathMap: colorPathMap,
    );
  }
}

enum ExpenseCategories implements BaseCategory {
  shopping,
  subscription,
  foods,
  health,
  transport;

  @override
  String get name => toString().split('.').last;
}

final expenseImagePathMap = PathMapParent<ExpenseCategories, String>(
  {
    ExpenseCategories.shopping: 'assets/images/shopping.png',
    ExpenseCategories.subscription: 'assets/images/salary.png',
    ExpenseCategories.foods: 'assets/images/food.png',
    ExpenseCategories.health: 'assets/images/shopping.png',
    ExpenseCategories.transport: 'assets/images/transport.png',
  },
  ExpenseCategories.values.toSet(),
)..validateKeys(ExpenseCategories.values);
final expenseColorPathMap = PathMapParent<ExpenseCategories, Color>(
  {
    ExpenseCategories.shopping: yYellowColor,
    ExpenseCategories.subscription: yPurpleColor,
    ExpenseCategories.foods: yOrangeColor,
    ExpenseCategories.health: yGreenColor,
    ExpenseCategories.transport: yBlueColor,
  },
  ExpenseCategories.values.toSet(),
)..validateKeys(ExpenseCategories.values);
