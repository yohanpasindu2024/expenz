import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:expenz/reusables/reusable_text_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseIncomeInputForm extends StatefulWidget {
  final int pageState; // * Page state
  final Color color; // * Color
  const ExpenseIncomeInputForm({
    super.key,
    required this.pageState,
    required this.color,
  });

  @override
  State<ExpenseIncomeInputForm> createState() => _ExpenseIncomeInputFormState();
}

class _ExpenseIncomeInputFormState extends State<ExpenseIncomeInputForm> {
  IncomeCategories _incomeCategory =
      IncomeCategories.sallary; // * Income category
  ExpenseCategories _expenseCategory =
      ExpenseCategories.health; // * Expense category

  final _formKey = GlobalKey<FormState>(); // * Form key
  final TextEditingController _incomeTitleControllet =
      TextEditingController(); // * Income title controller
  final TextEditingController _incomeDescriptionController =
      TextEditingController(); // * Income description controller
  final TextEditingController _incomeAmountController =
      TextEditingController(); // * Income amount controller
  final TextEditingController _expenseTitleControllet =
      TextEditingController(); // * Expense title controller
  final TextEditingController _expenseDescriptionController =
      TextEditingController(); // * Expense description controller
  final TextEditingController _expenseAmountController =
      TextEditingController(); // * Expense amount controller
  DateTime _selectedDate = DateTime.now(); // * Selected date
  DateTime _selectedTime = DateTime.now(); // * Selected time

  @override
  void dispose() {
    _incomeTitleControllet.dispose(); // * Dispose the income title controller
    _incomeDescriptionController
        .dispose(); // * Dispose the income description controller
    _incomeAmountController.dispose(); // * Dispose the income amount controller
    _expenseTitleControllet.dispose(); // * Dispose the expense title controller
    _expenseDescriptionController
        .dispose(); // * Dispose the expense description controller
    _expenseAmountController
        .dispose(); // * Dispose the expense amount controller
    super.dispose(); // * Call the super dispose method
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.705,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.33,
      ),
      decoration: BoxDecoration(
        color: yWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            y400,
          ),
          topRight: Radius.circular(
            y400,
          ),
        ),
      ),
      child: Padding(
        // * Padding for the form
        padding: const EdgeInsets.symmetric(
          horizontal: y250,
          vertical: y300,
        ),
        child: Form(
          // * Form for the input fields
          key: _formKey,
          child: Column(
            children: [
              // * Dropdown TextField
              DropdownButtonFormField(
                value:
                    widget.pageState == 0 ? _incomeCategory : _expenseCategory,
                decoration: dropDownInputDecoration(),
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
                    widget.pageState == 0
                        ? _incomeCategory = value as IncomeCategories
                        : _expenseCategory = value as ExpenseCategories;
                  });
                },
              ),
              getHeightSpacer(), // * Spacer for height
              // * Text field for title input
              TextField(
                controller: widget.pageState == 0
                    ? _incomeTitleControllet
                    : _expenseTitleControllet,
                cursorColor: widget.color,
                // autofocus: true, // * Autofocus the text field
                textInputAction: TextInputAction.next,
                cursorOpacityAnimates: true,
                cursorHeight: y200,
                style: TextStyle(
                  color: yBlackColor.withValues(
                    alpha: 0.8,
                  ),
                  fontWeight: FontWeight.w500,
                ),
                decoration: inputDecoration(
                  yTitle,
                ),
              ),
              getHeightSpacer(), // * Spacer for height
              // * Text field for description input
              TextField(
                controller: widget.pageState == 0
                    ? _incomeDescriptionController
                    : _expenseDescriptionController,
                cursorColor: widget.color,
                textInputAction: TextInputAction.next,
                cursorOpacityAnimates: true,
                cursorHeight: y200,
                style: TextStyle(
                  color: yBlackColor.withValues(
                    alpha: 0.8,
                  ),
                  fontWeight: FontWeight.w500,
                ),
                decoration: inputDecoration(
                  yDescription,
                ),
              ),
              getHeightSpacer(), // * Spacer for height
              // * Text field for amount input
              TextField(
                controller: widget.pageState == 0
                    ? _incomeAmountController
                    : _expenseAmountController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                cursorColor: widget.color,
                cursorOpacityAnimates: true,
                cursorHeight: y200,
                style: TextStyle(
                  color: yBlackColor.withValues(
                    alpha: 0.8,
                  ),
                  fontWeight: FontWeight.w500,
                ),
                decoration: inputDecoration(
                  yAmount,
                ),
              ),
              getHeightSpacer(), // * Spacer for height
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        y500,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(2010),
                          lastDate: DateTime.now(),
                          keyboardType: TextInputType.datetime,
                        ).then((value) {
                          setState(() {
                            value == null
                                ? _selectedDate = DateTime.now()
                                : _selectedDate = value;
                          });
                        });
                      },
                      borderRadius: BorderRadius.circular(
                        y500,
                      ),
                      child: getSelectButton(
                        label: '$ySelect $yDate',
                        color: yPurpleColor,
                        icon: Icons.calendar_month_outlined,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(_selectedDate),
                    style: TextStyle(
                      color: yBlackColor.withValues(
                        alpha: 0.5,
                      ),
                    ),
                    textAlign: TextAlign.end,
                    softWrap: true,
                  ),
                ],
              ), // * Row for the Date picker
              getHeightSpacer(), // * Spacer for height
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        y500,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          setState(() {
                            if (value != null) {
                              _selectedTime = DateTime(
                                _selectedDate.year,
                                _selectedDate.month,
                                _selectedDate.day,
                                value.hour,
                                value.minute,
                              );
                            }
                          });
                        });
                      },
                      borderRadius: BorderRadius.circular(
                        y500,
                      ),
                      child: getSelectButton(
                        label: '$ySelect $yTime',
                        color: yYellowColor,
                        icon: Icons.timer,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat.jm().format(_selectedTime),
                    style: TextStyle(
                      color: yBlackColor.withValues(
                        alpha: 0.5,
                      ),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ), // * Row for the Time picker
              getHeightSpacer(), // * Spacer for height
              Divider(
                color: yBlackColor.withValues(
                  alpha: 0.12,
                ),
                thickness: 1.2,
              ), // * Divider
              getHeightSpacer(), // * Spacer for height
              // * Row for the Add button
              ReusableTextButton(
                color: widget.color,
                text: yAdd,
                borderRadius: y500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // * Select button
  Widget getSelectButton({
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.063,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          y500,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: y200,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: yWhiteColor,
              size: y250,
            ),
            SizedBox(
              width: y150,
            ),
            Text(
              label,
              style: TextStyle(
                color: yWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // * Spacer for height
  Widget getHeightSpacer() {
    return SizedBox(
      height: y150,
    );
  }

  // * Input decoration for dropdown
  InputDecoration dropDownInputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
        left: y25,
        top: y150,
        bottom: y150,
        right: y300,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.color.withValues(
            alpha: 0.5,
          ),
        ),
        borderRadius: BorderRadius.circular(
          y500,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: yBlackColor.withValues(
            alpha: 0.5,
          ),
        ),
        borderRadius: BorderRadius.circular(
          y500,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: yOrangeColor.withValues(
            alpha: 0.5,
          ),
        ),
        borderRadius: BorderRadius.circular(
          y500,
        ),
      ),
    );
  }

  // * Input decoration for text fields
  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(
        horizontal: y200,
        vertical: y150,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.color.withValues(
            alpha: 0.5,
          ),
        ),
        borderRadius: BorderRadius.circular(
          y500,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: yBlackColor.withValues(
            alpha: 0.5,
          ),
        ),
        borderRadius: BorderRadius.circular(
          y500,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: yOrangeColor.withValues(
            alpha: 0.5,
          ),
        ),
        borderRadius: BorderRadius.circular(
          y500,
        ),
      ),
    );
  }
}
