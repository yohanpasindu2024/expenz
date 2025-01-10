import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part "expense_model.g.dart";

// * Expense Model class
@JsonSerializable()
class Expense {
  final String id, description;
  @JsonKey(
    fromJson: _imagePathMapFromJSON,
    toJson: _imagePathMapToJSON,
  )
  final Map<ExpenseCategories, String> imagePathMap;
  @JsonKey(
    fromJson: _colorPathMapFromJSON,
    toJson: _colorPathMapToJSON,
  )
  final Map<ExpenseCategories, Color> colorPathMap;
  @JsonKey(
    toJson: _expenseCategoryToJSON,
    fromJson: _expenseCategoryFromJSON,
  )
  final ExpenseCategories category;
  final double amount;
  final DateTime date;
  final DateTime time;

  factory Expense.fromJSON(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJSON() => _$ExpenseToJson(this);

  Expense({
    required this.id,
    required this.description,
    required this.imagePathMap,
    required this.colorPathMap,
    required this.category,
    required this.amount,
    required this.date,
    required this.time,
  });
}

// * Custom Converters for imagePathMap and colorPathMap

// * Iamge path map converter
Map<String, dynamic> _imagePathMapToJSON(
  Map<ExpenseCategories, String> imagePathMap,
) {
  return imagePathMap.map(
    (key, value) {
      return MapEntry(
        key.name,
        value,
      );
    },
  );
}

Map<ExpenseCategories, String> _imagePathMapFromJSON(
  Map<String, dynamic> json,
) {
  return json.map(
    (key, value) {
      return MapEntry(
        ExpenseCategories.values.byName(key),
        value as String,
      );
    },
  );
}

// * Color path map converter
Map<String, dynamic> _colorPathMapToJSON(
  Map<ExpenseCategories, Color> colorPathMap,
) {
  return colorPathMap.map(
    (key, value) {
      return MapEntry(
        key.name,
        value.toString(),
      );
    },
  );
}

Map<ExpenseCategories, Color> _colorPathMapFromJSON(
  Map<String, dynamic> json,
) {
  return json.map(
    (key, value) {
      return MapEntry(
        ExpenseCategories.values.byName(key),
        Color(value as int),
      );
    },
  );
}

// * Expense category converter
int _expenseCategoryToJSON(ExpenseCategories category) => category.index;

ExpenseCategories _expenseCategoryFromJSON(int index) =>
    ExpenseCategories.values[index];

// * Expense Categories
@JsonEnum()
enum ExpenseCategories {
  shopping,
  subscription,
  foods,
  health,
  transport;
}

// * Expense Image Path Map
final Map<ExpenseCategories, String> expenseImagePathMap = {
  ExpenseCategories.shopping: 'assets/images/shopping.png',
  ExpenseCategories.subscription: 'assets/images/salary.png',
  ExpenseCategories.foods: 'assets/images/food.png',
  ExpenseCategories.health: 'assets/images/shopping.png',
  ExpenseCategories.transport: 'assets/images/transport.png',
};

// * Expense Color Path Map
final Map<ExpenseCategories, Color> expenseColorPathMap = {
  ExpenseCategories.shopping: yYellowColor,
  ExpenseCategories.subscription: yPurpleColor,
  ExpenseCategories.foods: yOrangeColor,
  ExpenseCategories.health: yGreenColor,
  ExpenseCategories.transport: yBlueColor,
};
