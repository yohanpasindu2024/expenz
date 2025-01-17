import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/recent_transcation_model.dart';
import 'package:expenz/screens/add_new_page/add_new_page.dart';
import 'package:expenz/screens/buget_page/budget_page.dart';
import 'package:expenz/screens/home_page/home_page.dart';
import 'package:expenz/screens/main_layout/items/bottm_navigation_bar_widget.dart';
import 'package:expenz/screens/profile_page/profile_page.dart';
import 'package:expenz/screens/transcation_page/transcation_page.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:expenz/services/user_service.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // Page management
  int pageSelectionIndex = 0;
  bool isLoading = true;

  // Data management
  List<Expense>? listOfExpenses = [];
  List<Income>? listOfIncomes = [];
  List<RecentTranscationModel> listOfRecents = [];

  double totalIncome = 0;
  double totalExpense = 0;

  String userName = "";

  // Load user name
  Future<void> loadUserName() async {
    await UserService.getUserName().then(
      (value) {
        if (value != null) userName = value;
      },
    );
  }

  // Fetch all incomes
  Future<void> fetchAllIncomes() async {
    listOfIncomes = await IncomeService().getIncomeItems(message: (message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
    _calculateAllIncomes();
    if (listOfIncomes != null && listOfIncomes!.isNotEmpty) {
      listOfRecents.insert(
          0, RecentTranscationModel(income: listOfIncomes!.last));
    }
  }

  // Fetch all expenses
  Future<void> fetchAllExpenses() async {
    listOfExpenses = await ExpenseService().getExpensesAsList(
      message: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
    );
    _calculateAllExpenses();
    if (listOfExpenses != null && listOfExpenses!.isNotEmpty) {
      listOfRecents.insert(
          0, RecentTranscationModel(expense: listOfExpenses!.last));
    }
  }

  Future<void> addNewIncomeItem({required Income income}) async {
    await IncomeService().saveIncomeItem(
      income: income,
      message: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
    );
    setState(() {
      listOfIncomes!.insert(0, income);
      _calculateAllIncomes();
      if (!listOfRecents.contains(RecentTranscationModel(income: income))) {
        listOfRecents.insert(0, RecentTranscationModel(income: income));
      }
    });
  }

  Future<void> addNewExpenseItem({required Expense expense}) async {
    await ExpenseService().saveExpense(
      expense: expense,
      message: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
    );
    setState(() {
      listOfExpenses!.insert(0, expense);
      _calculateAllExpenses();
      if (!listOfRecents.contains(RecentTranscationModel(expense: expense))) {
        listOfRecents.insert(0, RecentTranscationModel(expense: expense));
      }
    });
  }

  Future<void> removeIncomeItem({required Income income}) async {
    await IncomeService().removeItem(
      index: income.id,
      message: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
    );

    setState(() {
      listOfIncomes!.removeWhere(
        (element) {
          return element.id == income.id;
        },
      );
      _calculateAllIncomes();
      _updateRecentTransactions();
    });
  }

  Future<void> removeExpenseItem({required Expense expense}) async {
    await ExpenseService().removeExpenseItem(
      index: expense.id,
      message: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
    );
    setState(() {
      listOfExpenses!.removeWhere(
        (element) {
          return element.id == expense.id;
        },
      );
      _calculateAllExpenses();
      _updateRecentTransactions();
    });
  }

  void _updateRecentTransactions() {
    listOfRecents.clear();

    // Add the most recent income
    if (listOfIncomes != null && listOfIncomes!.isNotEmpty) {
      listOfRecents.insert(
          0, RecentTranscationModel(income: listOfIncomes!.last));
    }

    // Add the most recent expense
    if (listOfExpenses != null && listOfExpenses!.isNotEmpty) {
      listOfRecents.insert(
          0, RecentTranscationModel(expense: listOfExpenses!.last));
    }
  }

  // Calculate all incomes
  void _calculateAllIncomes() {
    totalIncome = listOfIncomes!.fold(0, (sum, e) => sum + e.amount);
  }

  // Calculate all expenses
  void _calculateAllExpenses() {
    totalExpense = listOfExpenses!.fold(0, (sum, e) => sum + e.amount);
  }

  Future<void> loadData() async {
    await Future.wait([
      loadUserName(),
      fetchAllIncomes(),
      fetchAllExpenses(),
    ]);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final pages = [
      HomePage(
        listOfRecents: listOfRecents,
        totalValue: {
          "income": totalIncome,
          "expense": totalExpense,
        },
        userName: userName,
        listOfExpenses: listOfExpenses!,
        toAddNewPage: () {
          setState(() {
            pageSelectionIndex = 2;
          });
        },
      ),
      TranscationPage(
        removeExpense: (expense) => removeExpenseItem(expense: expense),
        removeIncome: (income) => removeIncomeItem(income: income),
        listOfItems: {
          "income": listOfIncomes!,
          "expense": listOfExpenses!,
        },
        toAddNewPage: () {
          setState(() {
            pageSelectionIndex = 2;
          });
        },
      ),
      AddNewPage(
        addExpense: (expense) => addNewExpenseItem(expense: expense),
        addIncome: (income) => addNewIncomeItem(income: income),
        listLength: {
          "income": listOfIncomes!.length,
          "expense": listOfExpenses!.length,
        },
      ),
      BudgetPage(
        listOfItems: {"income": listOfIncomes!, "expense": listOfExpenses!},
        total: {
          "income": totalIncome,
          "expense": totalExpense,
        },
      ),
      ProfilePage(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        onItemTapped: (value) {
          setState(() {
            pageSelectionIndex = value;
          });
          return value;
        },
        selectedIndex: pageSelectionIndex,
      ),
      body: pages[3],
    );
  }
}
