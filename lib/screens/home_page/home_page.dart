import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/paths.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/recent_transcation_model.dart';
import 'package:expenz/screens/home_page/items/amount_expenzes_card.dart';
import 'package:expenz/screens/transcation_page/items/income_expense_display_card.dart';
import 'package:expenz/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return HomePageView();
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
  });

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: yPurpleColor.withValues(
          alpha: 0.15,
        ),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Consumer<TransactionProvider>(
      builder: (context, value, child) {
        return SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.327,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: yPurpleColor.withValues(
                      alpha: 0.15,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        y650,
                      ),
                      bottomRight: Radius.circular(
                        y650,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: y150,
                      vertical: y200,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: y450,
                              width: y450,
                              decoration: BoxDecoration(
                                color: yGreyColor,
                                borderRadius: BorderRadius.circular(
                                  y500,
                                ),
                                border: Border.all(
                                  color: yPurpleColor,
                                  width: 1.1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: ClipOval(
                                child: value.profileImage,
                              ),
                            ),
                            Text(
                              "$yWelcomeTag ${value.userName.split(' ')[0]},",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: y200 + 3,
                                  ),
                            ),
                            SizedBox(
                              height: y150,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications,
                                color: yPurpleColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: y250,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IncomeExpenzesCard(
                              title: yIncome,
                              amount:
                                  "$yDollorSign${value.totalIncome.toInt()}",
                              imgagePath: yIncomeIconImage,
                              color: yGreenColor,
                            ),
                            IncomeExpenzesCard(
                              title: yExpense,
                              amount:
                                  "$yDollorSign${value.totalExpense.toInt()}",
                              imgagePath: yExpenseIconImage,
                              color: yOrangeColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: y150,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: y150,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        yRecentTransaction,
                        style: TextStyle(
                          fontSize: y150 + 4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: y200,
                      ),
                      ListView.builder(
                        itemCount: value.listOfRecents.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          RecentTranscationModel item =
                              value.listOfRecents[index];
                          if (item.expense != null) {
                            return IncomeExpenseDisplayCard(
                              containerColor: item.expense!.color,
                              amountColor: yOrangeColor,
                              imagePath: item.expense!.imagePath,
                              title: item.expense!.category.name,
                              description: item.expense!.description,
                              amount: "- ${item.expense!.amount}\$",
                              time: DateFormat("hh:mm a")
                                  .format(item.expense!.time),
                            );
                          }

                          if (item.income != null) {
                            return IncomeExpenseDisplayCard(
                              containerColor: item.income!.color,
                              amountColor: yGreenColor,
                              imagePath: item.income!.imagePath,
                              title: item.income!.category.name,
                              description: item.income!.description,
                              amount: "+ ${item.income!.amount}\$",
                              time: DateFormat("hh:mm a")
                                  .format(item.income!.time),
                            );
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
