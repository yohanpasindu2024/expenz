import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/income_model.dart';
import 'package:expenz/screens/transcation_page/items/income_expense_display_card.dart';
import 'package:expenz/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TranscationPage extends StatefulWidget {
  const TranscationPage({
    super.key,
  });

  @override
  State<TranscationPage> createState() => _TranscationPageState();
}

class _TranscationPageState extends State<TranscationPage> {
  @override
  Widget build(BuildContext context) {
    // CHANGE system bar colors
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: yWhiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Consumer<TransactionProvider>(
      builder: (context, value, child) {
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
                            itemCount: value.listOfIncomes.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            clipBehavior: Clip.none,
                            itemBuilder: (context, index) {
                              Income item = value.listOfIncomes[index];
                              return IncomeExpenseDisplayCard(
                                containerColor: item.color,
                                amountColor: yGreenColor,
                                imagePath: item.imagePath,
                                title: item.category.name,
                                description: item.description,
                                amount: "+ ${item.amount}\$",
                                time: DateFormat("hh:mm a").format(item.time),
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
                            itemCount: value.listOfExpenses.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            clipBehavior: Clip.none,
                            itemBuilder: (context, index) {
                              Expense item = value.listOfExpenses[index];
                              return IncomeExpenseDisplayCard(
                                containerColor: item.color,
                                amountColor: yOrangeColor,
                                imagePath: item.imagePath,
                                title: item.category.name,
                                description: item.description,
                                amount: "- ${item.amount}\$",
                                time: DateFormat("hh:mm a").format(item.time),
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
      },
    );
  }
}
