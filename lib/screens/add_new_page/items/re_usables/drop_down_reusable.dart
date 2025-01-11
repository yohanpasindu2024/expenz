import 'package:expenz/constants/values.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:flutter/material.dart';

class DropDownReusable extends StatefulWidget {
  final InputDecoration inputDecoration;
  final int pageState;
  final void Function(IncomeCategories?, ExpenseCategories?) onChanged;
  const DropDownReusable({
    super.key,
    required this.inputDecoration,
    required this.pageState,
    required this.onChanged,
  });

  @override
  State<DropDownReusable> createState() => _DropDownReusableState();
}

class _DropDownReusableState extends State<DropDownReusable> {
  IncomeCategories _incomeCategory =
      IncomeCategories.sallary; // * Income category
  ExpenseCategories _expenseCategory =
      ExpenseCategories.health; // * Expense category

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.pageState == 0 ? _incomeCategory : _expenseCategory,
      decoration: widget.inputDecoration,
      items: widget.pageState == 0
          ? IncomeCategories.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: y200,
                  ),
                  child: Text(
                    category.name,
                  ),
                ),
              );
            }).toList()
          : ExpenseCategories.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: y200,
                  ),
                  child: Text(
                    category.name,
                  ),
                ),
              );
            }).toList(),
      onChanged: (value) {
        setState(() {
          if (widget.pageState == 0) {
            widget.onChanged(value as IncomeCategories, null);
            _incomeCategory = value;
          } else {
            widget.onChanged(null, value as ExpenseCategories);
            _expenseCategory = value;
          }
        });
      },
    );
  }
}
