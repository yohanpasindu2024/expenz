import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:expenz/screens/add_new_page/items/expense_incom_input_form.dart';
import 'package:expenz/screens/add_new_page/items/free_text_field.dart';
import 'package:expenz/screens/add_new_page/items/toggle_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewPage extends StatefulWidget {
  final void Function(Income) addIncome;
  final void Function(Expense) addExpense;
  final Map<String, int> listLength;
  const AddNewPage({
    super.key,
    required this.addIncome,
    required this.addExpense,
    required this.listLength,
  });

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  Color _scaffoldBackgroundColor =
      yGreenColor; // Set the scaffold background color
  int _pageState = 0; // 0 for expenses, 1 for income
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: _scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              // Expense and Income Toggle
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: y150,
                  vertical: y200,
                ),
                child: ToggleHeader(
                  onToggle: (Color color, int index) {
                    setState(() {
                      // Set state based on the toggle
                      _scaffoldBackgroundColor =
                          color; // Set color based on the toggle
                      _pageState = index; // Set page state based on the toggle
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: y150,
                ),
                child: FreeTextField(),
              ),
              ExpenseIncomeInputForm(
                pageState: _pageState,
                color: _scaffoldBackgroundColor,
                addExpense: (expense) => widget.addExpense(expense),
                addIncome: (income) => widget.addIncome(income),
                listLength: widget.listLength,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
