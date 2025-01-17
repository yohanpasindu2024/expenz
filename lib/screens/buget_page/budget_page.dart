import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/screens/buget_page/items/buddget_page_pie_chart.dart';
import 'package:expenz/screens/buget_page/items/budgget_page_app_bar.dart';
import 'package:expenz/screens/buget_page/items/budgget_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BudgetPage extends StatefulWidget {
  final Map<String, List<dynamic>> listOfItems;
  final Map<String, double> total;
  const BudgetPage({
    super.key,
    required this.listOfItems,
    required this.total,
  });

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  bool pageState = false;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: yWhiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      appBar: BuggutPageAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.none,
          padding: const EdgeInsets.symmetric(
            horizontal: y200,
            vertical: y150,
          ),
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          child: Column(
            children: [
              BudggetToggle(
                onTap: (page) {
                  setState(() {
                    pageState = page;
                  });
                },
              ),
              SizedBox(
                height: y350,
              ),
              BuddgetPagePieChart(
                listOfItems: widget.listOfItems,
                pageState: pageState,
                total: widget.total,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
