import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'income_model.g.dart';

@JsonSerializable()
class Income {
  final String id, description;
  @JsonKey(
    toJson: _imagePathMapToJSON,
    fromJson: _imagePathMapFromJSON,
  )
  final Map<IncomeCategories, String> imagePathMap;
  @JsonKey(
    toJson: _colorPathMapToJSON,
    fromJson: _colorPathMapFromJSON,
  )
  final Map<IncomeCategories, Color> colorPathMap;
  @JsonKey(
    toJson: _incomeCategoriesToJSON,
    fromJson: _incomeCategoriesFromJSON,
  )
  final IncomeCategories category;
  final double amount;
  final DateTime date;
  final DateTime time;

  Map<String, dynamic> toJson() => _$IncomeToJson(this);

  factory Income.dromJSON(Map<String, dynamic> jsonObj) =>
      _$IncomeFromJson(jsonObj);

  Income({
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

// * Custome Converters

// * Convert image paths to the json objects
Map<String, dynamic> _imagePathMapToJSON(
  Map<IncomeCategories, String> imagePathMap,
) {
  return imagePathMap.map(
    (key, value) => MapEntry(
      key.name,
      value,
    ),
  );
}

// * Convert json objects to Dart objects
Map<IncomeCategories, String> _imagePathMapFromJSON(
  Map<String, dynamic> json,
) {
  return json.map(
    (key, value) =>
        MapEntry(IncomeCategories.values.byName(key), value as String),
  );
}

// * Convert color path map to json objects
Map<String, String> _colorPathMapToJSON(
  Map<IncomeCategories, Color> colorObj,
) {
  return colorObj.map(
    (key, value) => MapEntry(
      key.name,
      value.toString(),
    ),
  );
}

// * Convert json color path objects to Dart objects
Map<IncomeCategories, Color> _colorPathMapFromJSON(
  Map<String, String> jsonObj,
) {
  return jsonObj.map(
    (key, value) => MapEntry(
      IncomeCategories.values.byName(key),
      Color(
        int.parse(value.toString(), radix: 16),
      ),
    ),
  );
}

// * Convert Income categories to Json indexes
int _incomeCategoriesToJSON(IncomeCategories category) => category.index;

// * Convert indexs to Income Categories
IncomeCategories _incomeCategoriesFromJSON(int index) =>
    IncomeCategories.values[index];

// * Enum for Income Categories
@JsonEnum()
enum IncomeCategories {
  sallary,
  freelance,
  passiveIncome,
  gift;
}

// * Map for Income Image Path
final Map<IncomeCategories, String> incomeImagePathMap = {
  IncomeCategories.sallary: 'assets/icons/salary.png',
  IncomeCategories.freelance: 'assets/icons/freelance.png',
  IncomeCategories.passiveIncome: 'assets/icons/transport.png',
  IncomeCategories.gift: 'assets/icons/food.png',
};

// * Map for Income Color Path
final Map<IncomeCategories, Color> incomeColorPathMap = {
  IncomeCategories.sallary: yGreenColor,
  IncomeCategories.freelance: yBlackColor,
  IncomeCategories.passiveIncome: yBlueColor,
  IncomeCategories.gift: yYellowColor,
};
