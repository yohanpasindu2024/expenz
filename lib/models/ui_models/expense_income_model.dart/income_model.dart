import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/parent_expense_income_model.dart';
import 'package:flutter/material.dart';

class IncomeModel extends ParentExpenseIncomeModel {
  IncomeModel({
    required super.id,
    required super.imagePathMap,
    required super.colorPathMap,
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.time,
  });

  factory IncomeModel.create({
    required String id,
    required IncomeCategories category,
    required String description,
    required double amount,
    required DateTime date,
    required DateTime time,
    required PathMapParent<IncomeCategories, String> imagePathMap,
    required PathMapParent<IncomeCategories, Color> colorPathMap,
  }) {
    return IncomeModel(
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

enum IncomeCategories implements BaseCategory {
  sallary,
  freelance,
  passiveIncome,
  gift;

  @override
  String get name => toString().split('.').last;
}

final incomeImagePathMap = PathMapParent<IncomeCategories, String>(
  {
    IncomeCategories.sallary: 'assets/icons/salary.png',
    IncomeCategories.freelance: 'assets/icons/freelance.png',
    IncomeCategories.passiveIncome: 'assets/icons/transport.png',
    IncomeCategories.gift: 'assets/icons/food.png',
  },
  IncomeCategories.values.toSet(),
)..validateKeys(IncomeCategories.values);

final incomeColorPathMap = PathMapParent<IncomeCategories, Color>(
  {
    IncomeCategories.sallary: yGreenColor,
    IncomeCategories.freelance: yBlackColor,
    IncomeCategories.passiveIncome: yBlueColor,
    IncomeCategories.gift: yYellowColor,
  },
  IncomeCategories.values.toSet(),
)..validateKeys(IncomeCategories.values);
