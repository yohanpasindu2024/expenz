import 'package:flutter/material.dart';

class ParentExpenseIncomeModel {
  final String iconPath;
  final Color iconColor;
  final String title;
  final String description;
  final double amount;
  final String date;
  final String time;

  ParentExpenseIncomeModel({
    required this.iconPath,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.time,
  });
}
