import 'package:expenz/constants/paths.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/recent_transcation_model.dart';
import 'package:expenz/screens/add_new_page/add_new_page.dart';
import 'package:expenz/screens/buget_page/budget_page.dart';
import 'package:expenz/screens/home_page/home_page.dart';
import 'package:expenz/screens/profile_page/profile_page.dart';
import 'package:expenz/screens/transcation_page/transcation_page.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:expenz/services/user_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  // Page management
  int pageSelectionIndex = 0;
  int addNewPageBehaviour = 0; // 0 for income 1 for expense

  // Data management
  List<Expense> listOfExpenses = [];
  List<Income> listOfIncomes = [];
  List<RecentTranscationModel> listOfRecents = [];

  double totalIncome = 0;
  double totalExpense = 0;

  String userName = "";
  late Image profileImage;

  // Fetch All Expenses
  Future<void> fetchAllExpenses(BuildContext context) async {
    List<Expense> listOfFetchedItems =
        await ExpenseService().getExpensesAsList(context) ?? [];
    listOfExpenses = listOfFetchedItems;
    _calculateAllExpenses();
    if (listOfFetchedItems.isNotEmpty) {
      listOfRecents.add(
        RecentTranscationModel(
          expense: listOfFetchedItems.last,
          income: null,
        ),
      );
    }
    notifyListeners();
  }

  // Fetch ALl Incomes
  Future<void> fetchAllIncomes(BuildContext context) async {
    List<Income> listOfFetchedIncomes =
        await IncomeService().getIncomeItems(context) ?? [];
    listOfIncomes = listOfFetchedIncomes;
    _calculateAllIncomes();
    if (listOfFetchedIncomes.isNotEmpty) {
      listOfRecents.add(
        RecentTranscationModel(
          income: listOfFetchedIncomes.last,
          expense: null,
        ),
      );
    }
    notifyListeners();
  }

  // Add new income item
  void addIncomeItem(Income item, BuildContext context) async {
    await IncomeService().saveIncomeItem(item, context);
    listOfIncomes.add(item);
    notifyListeners();
  }

  // Add new expense item
  void addExpenseItem(Expense item, BuildContext context) async {
    await ExpenseService().saveExpense(item, context);
    listOfExpenses.add(item);
    notifyListeners();
  }

  // Calculate all incomes
  void _calculateAllIncomes() {
    totalIncome = listOfIncomes.fold(0, (sum, e) => sum + e.amount);
  }

  // Calculate all expenses
  void _calculateAllExpenses() {
    totalExpense = listOfExpenses.fold(0, (sum, e) => sum + e.amount);
  }

  // Pages
  List<Widget> get pages {
    return [
      HomePage(),
      TranscationPage(),
      AddNewPage(),
      BudgetPage(),
      ProfilePage(),
    ];
  }

  // Update User name
  Future<void> _getUserName() async {
    UserService.getUserName().then((value) {
      if (value != null) {
        userName = value;
      }
    });
  }

  Future<void> _loadImage() async {
    profileImage = Image.asset(
      yProfileImage,
      fit: BoxFit.cover,
    );
  }

  void loadUserData() {
    _getUserName();
    _loadImage();
  }
}
