import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/paths.dart';
import 'package:flutter/material.dart';

class Income {
  final String id, description;
  final IncomeCategories category;
  final double amount;
  final DateTime date, time;

  // INCOME constructor
  Income({
    required this.id,
    required this.description,
    required this.category,
    required this.amount,
    required this.date,
    required this.time,
  });

  // GET image path and color
  String get imagePath => incomeImagePathMap[category] ?? ySalaryIconImage;
  Color get color => incomeColorPathMap[category] ?? yGreenColor;

  // SERIALIZE Dart ----> Json
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

  // DESIRIALIZE json ----> Dart Object
  factory Income.fromJSON(Map<String, dynamic> json) {
    return Income(
      id: json["id"] as String,
      description: json["desc"] as String,
      category: IncomeCategories.values[json["category"]],
      amount: (json["amount"] as num).toDouble(),
      date: DateTime.parse(json["date"] as String),
      time: DateTime.parse(json["time"] as String),
    );
  }
}

// ENUM form incomes
enum IncomeCategories {
  sallary,
  freelance,
  passiveIncome,
  gift;
}

// MAP for Income Image Path
final Map<IncomeCategories, String> incomeImagePathMap = {
  IncomeCategories.sallary: ySalaryIconImage,
  IncomeCategories.freelance: yFreeLanceIconImage,
  IncomeCategories.passiveIncome: yPasinveIncomeImage,
  IncomeCategories.gift: yGiftImage,
};

// MAP for Income Color Path
final Map<IncomeCategories, Color> incomeColorPathMap = {
  IncomeCategories.sallary: yGreenColor,
  IncomeCategories.freelance: yBlackColor,
  IncomeCategories.passiveIncome: yBlueColor,
  IncomeCategories.gift: yYellowColor,
};
