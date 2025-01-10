// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
      id: json['id'] as String,
      description: json['description'] as String,
      imagePathMap:
          _imagePathMapFromJSON(json['imagePathMap'] as Map<String, dynamic>),
      colorPathMap:
          _colorPathMapFromJSON(json['colorPathMap'] as Map<String, dynamic>),
      category: _expenseCategoryFromJSON((json['category'] as num).toInt()),
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'imagePathMap': _imagePathMapToJSON(instance.imagePathMap),
      'colorPathMap': _colorPathMapToJSON(instance.colorPathMap),
      'category': _expenseCategoryToJSON(instance.category),
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'time': instance.time.toIso8601String(),
    };
