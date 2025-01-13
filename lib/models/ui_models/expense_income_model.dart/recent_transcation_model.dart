import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';

class RecentTranscationModel {
  final Income? income;
  final Expense? expense;

  RecentTranscationModel({
    this.income,
    this.expense,
  });
}
