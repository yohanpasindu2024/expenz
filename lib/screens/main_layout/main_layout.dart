import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:expenz/screens/add_new_page/add_new_page.dart';
import 'package:expenz/screens/buget_page/budget_page.dart';
import 'package:expenz/screens/home_page/home_page.dart';
import 'package:expenz/screens/main_layout/items/bottm_navigation_bar_widget.dart';
import 'package:expenz/screens/profile_page/profile_page.dart';
import 'package:expenz/screens/transcation_page/transcation_page.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  late final List<Widget> mainLayoutPages;

  int addNewPageState = 0;
  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  void fetchAllExpenses() async {
    expenseList = await ExpenseService().getExpensesAsList() ?? [];
  }

  void fetchAllIncomes() async {
    incomeList = await IncomeService().getIncomeItems(context) ?? [];
  }

  void addIncomeItem(Income item) async {
    await IncomeService().saveIncomeItem(item, context);
    incomeList.add(item);
  }

  void addExpenseItem(Expense item) async {
    await ExpenseService().saveExpense(item, context);
    expenseList.add(item);
  }

  @override
  void initState() {
    fetchAllExpenses();
    fetchAllIncomes();
    mainLayoutPages = <Widget>[
      HomePage(),
      TranscationPage(),
      AddNewPage(
        addNewItem: (p0, p1, p2) {
          setState(() {
            addNewPageState = p2;
            if (addNewPageState == 0) {
              if (p0 != null) addIncomeItem(p0);
            }

            if (addNewPageState == 1) {
              if (p1 != null) addExpenseItem(p1);
            }
          });
        },
      ),
      BudgetPage(),
      ProfilePage(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        onItemTapped: (value) {
          setState(() {
            _selectedIndex = value;
          });
          return value;
        },
        selectedIndex: _selectedIndex,
      ),
      body: mainLayoutPages[2],
    );
  }
}
