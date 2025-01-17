import 'package:expenz/constants/values.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BuddgetPagePieChart extends StatefulWidget {
  final Map<String, List<dynamic>> listOfItems;
  final Map<String, double> total;
  final bool pageState;
  const BuddgetPagePieChart({
    super.key,
    required this.listOfItems,
    required this.pageState,
    required this.total,
  });

  @override
  State<BuddgetPagePieChart> createState() => _BuddgetPagePieChartState();
}

class _BuddgetPagePieChartState extends State<BuddgetPagePieChart> {
  @override
  Widget build(BuildContext context) {
    final double incomeTotal = widget.total["income"] as double;
    final double expenseTotal = widget.total["expense"] as double;

    return AspectRatio(
      aspectRatio: 1.3,
      child: Center(
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                centerSpaceRadius: 70,
                sections: _getPieChartSectionData(),
                
              ),
            ),
            Center(
              child: Text(
                "\$${widget.pageState ? incomeTotal.toInt() : expenseTotal.toInt()}",
                style: TextStyle(
                  fontSize: y150 + 3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getPieChartSectionData() {
    final List<Expense> listOfExpenses =
        widget.listOfItems["expense"] as List<Expense>;
    final List<Income> listOfIncomes =
        widget.listOfItems["income"] as List<Income>;
    double totalExpenses = listOfExpenses.fold(0, (sum, e) => sum + e.amount);

    final Map<ExpenseCategories, double> totalExpenseCategoryValue = {
      ExpenseCategories.shopping: 0,
      ExpenseCategories.subscription: 0,
      ExpenseCategories.foods: 0,
      ExpenseCategories.health: 0,
      ExpenseCategories.transport: 0,
    };

    final Map<IncomeCategories, double> totalIncomeCategoryValue = {
      IncomeCategories.sallary: 0,
      IncomeCategories.freelance: 0,
      IncomeCategories.passiveIncome: 0,
      IncomeCategories.gift: 0,
    };

    for (var expense in listOfExpenses) {
      totalExpenseCategoryValue[expense.category] =
          (totalExpenseCategoryValue[expense.category] ?? 0) + expense.amount;
    }

    for (var income in listOfIncomes) {
      totalIncomeCategoryValue[income.category] =
          (totalIncomeCategoryValue[income.category] ?? 0) + income.amount;
    }

    double totalIncome = listOfIncomes.fold(0, (sum, e) => sum + e.amount);

    if (widget.pageState) {
      return totalIncomeCategoryValue.entries
          .where((entry) => entry.value > 0)
          .map((entry) {
        double percentage = (entry.value / totalIncome) * 100;

        return PieChartSectionData(
          value: entry.value,
          color: incomeColorPathMap[entry.key],
          radius: 50,
          title: "${percentage.toStringAsFixed(1)}%",
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      }).toList();
    } else {
      return totalExpenseCategoryValue.entries
          .where((entry) => entry.value > 0)
          .map((entry) {
        double percentage = (entry.value / totalExpenses) * 100;

        return PieChartSectionData(
          value: entry.value,
          color: expenseColorPathMap[entry.key],
          radius: 50,
          title: "${percentage.toStringAsFixed(1)}%",
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      }).toList();
    }
  }
}
