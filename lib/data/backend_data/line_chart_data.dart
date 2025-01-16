import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';

import 'dart:math' as math;

class LineChartDataSet {
  static double getMaxValue({required List<Expense> listOfItems}) {
    List<double> iteratedListOfValues = [];

    for (var item in listOfItems) {
      iteratedListOfValues.add(item.amount);
    }

    return iteratedListOfValues.reduce(math.max);
  }

  static List<String> getXLineTitles({required List<Expense> listOfItems}) {
    List<String> listOfCategories = [];

    while (listOfCategories.length <= 3) {
      for (var item in listOfItems) {
        listOfCategories.add(item.category.name);
      }
    }
    return listOfCategories;
  }

  static List<FlSpot> getSpots({required List<Expense> listOfItems}) {
    List<FlSpot> listOfSposts = [];
    List<double> listOfValues = [];

    for (var item in listOfItems) {
      listOfValues.add(item.amount);
    }

    for (var i = 0; i < listOfValues.length; i++) {
      listOfSposts.add(FlSpot(i.toDouble(), listOfValues[i]));
    }

    return listOfSposts;
  }
}
