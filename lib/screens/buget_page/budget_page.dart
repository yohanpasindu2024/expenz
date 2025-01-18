import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:expenz/screens/buget_page/items/buddget_page_pie_chart.dart';
import 'package:expenz/screens/buget_page/items/budgget_page_app_bar.dart';
import 'package:expenz/screens/buget_page/items/budgget_toggle.dart';
import 'package:expenz/screens/buget_page/items/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BudgetPage extends StatefulWidget {
  final Map<String, List<dynamic>> listOfItems;
  final Map<String, double> total;
  const BudgetPage({
    super.key,
    required this.listOfItems,
    required this.total,
  });

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  bool pageState = false;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final List<Income> listOfIncomes =
        widget.listOfItems["income"] as List<Income>;
    final double totalIncome =
        listOfIncomes.fold(0, (sum, item) => sum + item.amount);
    final Map<IncomeCategories, double> incomeCategoryTotal = {
      IncomeCategories.sallary: 0,
      IncomeCategories.freelance: 0,
      IncomeCategories.passiveIncome: 0,
      IncomeCategories.gift: 0,
    };

    final Map<IncomeCategories, double> incomeBarwith = {
      IncomeCategories.sallary: 0,
      IncomeCategories.freelance: 0,
      IncomeCategories.passiveIncome: 0,
      IncomeCategories.gift: 0,
    };
    for (Income item in listOfIncomes) {
      incomeCategoryTotal[item.category] =
          (incomeCategoryTotal[item.category]!) + item.amount;
    }
    for (var item in incomeCategoryTotal.entries) {
      incomeBarwith[item.key] =
          item.value != 0 ? (item.value / totalIncome) : 0;
    }

    final List<Expense> listOfExpense =
        widget.listOfItems["expense"] as List<Expense>;
    final double expenseTotal =
        listOfExpense.fold(0, (sum, item) => sum + item.amount);
    final Map<ExpenseCategories, double> expenseCategoryTotal = {
      ExpenseCategories.foods: 0,
      ExpenseCategories.health: 0,
      ExpenseCategories.subscription: 0,
      ExpenseCategories.shopping: 0,
      ExpenseCategories.transport: 0,
    };
    final Map<ExpenseCategories, double> expenseBarWith = {
      ExpenseCategories.foods: 0,
      ExpenseCategories.health: 0,
      ExpenseCategories.subscription: 0,
      ExpenseCategories.shopping: 0,
      ExpenseCategories.transport: 0,
    };
    for (Expense item in listOfExpense) {
      expenseCategoryTotal[item.category] =
          (expenseCategoryTotal[item.category]!) + item.amount;
    }
    for (var item in expenseCategoryTotal.entries) {
      expenseBarWith[item.key] =
          item.value != 0 ? (item.value / expenseTotal) : 0;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: yWhiteColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: yWhiteColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      appBar: BuggutPageAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.none,
          padding: const EdgeInsets.symmetric(
            horizontal: y200,
            vertical: y150,
          ),
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          child: Column(
            children: [
              BudggetToggle(
                onTap: (page) {
                  setState(() {
                    pageState = page;
                  });
                },
              ),
              SizedBox(
                height: y350,
              ),
              BuddgetPagePieChart(
                listOfItems: widget.listOfItems,
                pageState: pageState,
                total: widget.total,
              ),
              SizedBox(
                height: y350,
              ),
              pageState
                  ? ListView.builder(
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: incomeBarwith.entries.toList().length,
                      itemBuilder: (context, index) {
                        final item = incomeBarwith.entries.toList()[index];
                        return item.value == 0
                            ? SizedBox()
                            : ProgressCard(
                                category: item.key.name,
                                width: item.value,
                                color: incomeColorPathMap[item.key]!,
                                value:
                                    "+\$${incomeCategoryTotal[item.key]!.toInt()}",
                                valueColor: yGreenColor,
                              );
                      },
                    )
                  : ListView.builder(
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: expenseBarWith.entries.toList().length,
                      itemBuilder: (context, index) {
                        final item = expenseBarWith.entries.toList()[index];
                        return item.value == 0
                            ? SizedBox()
                            : ProgressCard(
                                category: item.key.name,
                                width: item.value,
                                color: expenseColorPathMap[item.key]!,
                                value:
                                    "-\$${expenseCategoryTotal[item.key]!.toInt()}",
                                valueColor: yOrangeColor,
                              );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
