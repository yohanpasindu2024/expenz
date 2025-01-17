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
    double totalExpenses = listOfExpenses.fold(0, (sum, e) => sum + e.amount);

    final List<Income> listOfIncomes =
        widget.listOfItems["income"] as List<Income>;
    double totalIncome = listOfIncomes.fold(0, (sum, e) => sum + e.amount);

    if (widget.pageState) {
      return listOfIncomes.map((income) {
        double percentage = (income.amount / totalIncome) * 100;

        return PieChartSectionData(
            value: income.amount,
            color: incomeColorPathMap[income.category],
            radius: 50,
            title: "${percentage.toStringAsFixed(1)}%",
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ));
      }).toList();
    } else {
      return listOfExpenses.map((expense) {
        double percentage = (expense.amount / totalExpenses) * 100;

        return PieChartSectionData(
          value: expense.amount,
          color: expenseColorPathMap[expense.category],
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
