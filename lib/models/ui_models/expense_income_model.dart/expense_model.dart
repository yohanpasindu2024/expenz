
import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/paths.dart';
import 'package:flutter/material.dart';

class Expense {
  final String id, description;
  final ExpenseCategories category;
  final double amount;
  final DateTime date, time;

  // EXPENSE constructor
  Expense({
    required this.id,
    required this.description,
    required this.category,
    required this.amount,
    required this.date,
    required this.time,
  });

  // GET image path and color
  String get imagePath => expenseImagePathMap[category] ?? yFoodIconImage;
  Color get color => expenseColorPathMap[category] ?? yOrangeColor;

  // SERIALIZE DART ----> JSON
  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "desc": description,
      "category": category.index,
      "amount": amount,
      "date": date.toIso8601String(),
      "time": time.toIso8601String(),
    };
  }

  // DESERIALIZE JSON ----> DART
  factory Expense.fromJSON(Map<String, dynamic> json) {
    return Expense(
      id: json["id"] as String,
      description: json["desc"] as String,
      category: ExpenseCategories.values[json["category"]],
      amount: (json["amount"] as num).toDouble(),
      date: DateTime.parse(json["date"] as String),
      time: DateTime.parse(json["time"] as String),
    );
  }
}

// ENUM for expenses
enum ExpenseCategories {
  shopping,
  subscription,
  foods,
  health,
  transport;
}

// AMP for expense images
final Map<ExpenseCategories, String> expenseImagePathMap = {
  ExpenseCategories.shopping: 'assets/images/shopping.png',
  ExpenseCategories.subscription: 'assets/images/salary.png',
  ExpenseCategories.foods: 'assets/images/food.png',
  ExpenseCategories.health: 'assets/images/shopping.png',
  ExpenseCategories.transport: 'assets/images/transport.png',
};

// MAP for expense colors
final Map<ExpenseCategories, Color> expenseColorPathMap = {
  ExpenseCategories.shopping: yYellowColor,
  ExpenseCategories.subscription: yPurpleColor,
  ExpenseCategories.foods: yOrangeColor,
  ExpenseCategories.health: yGreenColor,
  ExpenseCategories.transport: yBlueColor,
};
