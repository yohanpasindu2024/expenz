import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:expenz/reusables/reusable_text_button.dart';
import 'package:expenz/screens/add_new_page/items/re_usables/drop_down_reusable.dart';
import 'package:expenz/screens/add_new_page/items/re_usables/picker_reusable.dart';
import 'package:expenz/screens/add_new_page/items/re_usables/text_field_reusable.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum AddNewTextFieldType {
  title,
  description,
  amount,
}

class ExpenseIncomeInputForm extends StatefulWidget {
  final int pageState; // * Page state
  final Color color; // * Color
  final void Function(Income?, Expense?) addNewItem;
  const ExpenseIncomeInputForm({
    super.key,
    required this.pageState,
    required this.color,
    required this.addNewItem,
  });

  @override
  State<ExpenseIncomeInputForm> createState() => _ExpenseIncomeInputFormState();
}

class _ExpenseIncomeInputFormState extends State<ExpenseIncomeInputForm> {
  final _formKey = GlobalKey<FormState>(); // * Form key
  ExpenseCategories expenseCategory = ExpenseCategories.shopping;
  IncomeCategories incomeCategory = IncomeCategories.gift;
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
              // Dropdown TextField
              DropDownReusable(
                inputDecoration: inputDecoration(
                  yCategory,
                  padding: EdgeInsets.symmetric(
                    vertical: y150,
                  ),
                ),
                pageState: widget.pageState,
                onChanged: (p0, p1) {
                  if (p0 != null) {
                    incomeCategory = p0;
                  }

                  if (p1 != null) {
                    expenseCategory = p1;
                  }
                },
              ),

              getHeightSpacer(),

              // Text field for title input
              TextFieldReusable(
                type: AddNewTextFieldType.title,
                controller: widget.pageState == 0
                    ? _incomeTitleControllet
                    : _expenseTitleControllet,
                inputDecoration: inputDecoration(yTitle),
                color: widget.color,
              ),

              getHeightSpacer(),

              // Text field for description input
              TextFieldReusable(
                type: AddNewTextFieldType.description,
                controller: widget.pageState == 0
                    ? _incomeDescriptionController
                    : _expenseDescriptionController,
                inputDecoration: inputDecoration(yDescription),
                color: widget.color,
              ),

              getHeightSpacer(),

              // Text field for amount input
              TextFieldReusable(
                type: AddNewTextFieldType.amount,
                controller: widget.pageState == 0
                    ? _incomeAmountController
                    : _expenseAmountController,
                inputDecoration: inputDecoration(yAmount),
                inputAction: TextInputAction.done,
                color: widget.color,
                inputType: TextInputType.number,
              ),

              getHeightSpacer(),

              // Date picker
              PickerReusable(
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
                icon: Icons.calendar_month_outlined,
                color: yPurpleColor,
                buttonText: '$ySelect $yDate',
                outPutText: DateFormat.yMMMd().format(_selectedDate),
              ),

              getHeightSpacer(),

              // Time Picker
              PickerReusable(
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
                icon: Icons.timer,
                buttonText: '$ySelect $yTime',
                outPutText: DateFormat.jm().format(_selectedTime),
                color: yYellowColor,
              ),

              getHeightSpacer(),

              Divider(
                color: yBlackColor.withValues(
                  alpha: 0.12,
                ),
                thickness: 1.2,
              ),

              getHeightSpacer(),

              ReusableTextButton(
                color: widget.color,
                text: yAdd,
                borderRadius: y500,
                onTap: () async {
                  if (widget.pageState == 0) {
                    List<Income>? incomeList =
                        await IncomeService().getIncomeItems(context);
                    int incomeIndex = incomeList?.length ?? 0;
                    Income newIncome = Income(
                      id: (incomeIndex + 1).toString(),
                      description: _incomeDescriptionController.text,
                      category: incomeCategory,
                      amount: double.tryParse(_incomeAmountController.text) ??
                          (throw Exception("Invalid amount")),
                      date: _selectedDate,
                      time: _selectedTime,
                    );
                    widget.addNewItem(newIncome, null);
                  }
                  if (widget.pageState == 1) {
                    List<Expense>? expenseList =
                        await ExpenseService().getExpensesAsList();
                    int expenseIndex = expenseList?.length ?? 0;
                    Expense newExpense = Expense(
                      id: (expenseIndex + 1).toString(),
                      description: _expenseDescriptionController.text,
                      category: expenseCategory,
                      amount: double.tryParse(_expenseAmountController.text) ??
                          (throw Exception('Invalid amount')),
                      date: _selectedDate,
                      time: _selectedTime,
                    );
                    widget.addNewItem(null, newExpense);
                  }
                },
              ),
            ],
          ),
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
  InputDecoration inputDecoration(
    String hintText, {
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: y200,
      vertical: y150,
    ),
  }) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: padding,
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
