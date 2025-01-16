import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:expenz/screens/transcation_page/items/income_expense_display_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TranscationPage extends StatefulWidget {
  final Map<String, List<dynamic>> listOfItems;
  final void Function(Income) removeIncome;
  final void Function(Expense) removeExpense;
  const TranscationPage({
    super.key,
    required this.listOfItems,
    required this.removeIncome,
    required this.removeExpense,
  });

  @override
  State<TranscationPage> createState() => _TranscationPageState();
}

class _TranscationPageState extends State<TranscationPage> {
  @override
  Widget build(BuildContext context) {
    final List<Income> listOfIncomes =
        widget.listOfItems["income"] as List<Income>;
    final List<Expense> listOfExpenses =
        widget.listOfItems["expense"] as List<Expense>;
    // Change system bar colors
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: yWhiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$ySeeAll $yYour $yFinancialReport",
          style: TextStyle(
            color: yPurpleColor,
            fontSize: y200,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: yWhiteColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: y150,
            vertical: y200,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      yIncomes,
                      style: TextStyle(
                        fontSize: y150 + 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: y250,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: y150,
                      ),
                      child: ListView.builder(
                        itemCount: listOfIncomes.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          Income item = listOfIncomes[index];
                          return Dismissible(
                            key: ValueKey(item),
                            onDismissed: (direction) async {
                              widget.removeIncome(item);
                            },
                            child: IncomeExpenseDisplayCard(
                              containerColor: item.color,
                              amountColor: yGreenColor,
                              imagePath: item.imagePath,
                              title: item.category.name,
                              description: item.description,
                              amount: "+ ${item.amount}\$",
                              time: DateFormat("hh:mm a").format(item.time),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: y200,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      yExpenses,
                      style: TextStyle(
                        fontSize: y150 + 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: y250,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: y150,
                      ),
                      child: ListView.builder(
                        itemCount: listOfExpenses.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          Expense item = listOfExpenses[index];
                          return Dismissible(
                            key: ValueKey(item),
                            onDismissed: (direction) {
                              widget.removeExpense(item);
                            },
                            child: IncomeExpenseDisplayCard(
                              containerColor: item.color,
                              amountColor: yOrangeColor,
                              imagePath: item.imagePath,
                              title: item.category.name,
                              description: item.description,
                              amount: "- ${item.amount}\$",
                              time: DateFormat("hh:mm a").format(item.time),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
