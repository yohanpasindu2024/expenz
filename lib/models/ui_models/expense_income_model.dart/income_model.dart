import 'package:expenz/models/ui_models/expense_income_model.dart/parent_expense_income_model.dart';

class IncomeModel extends ParentExpenseIncomeModel {
  IncomeModel({
    required super.iconPath,
    required super.iconColor,
    required super.title,
    required super.description,
    required super.amount,
    required super.date,
    required super.time,
  });
}
