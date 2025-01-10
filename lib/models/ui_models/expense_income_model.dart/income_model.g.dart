// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Income _$IncomeFromJson(Map<String, dynamic> json) => Income(
      id: json['id'] as String,
      description: json['description'] as String,
      imagePathMap:
          _imagePathMapFromJSON(json['imagePathMap'] as Map<String, dynamic>),
      colorPathMap:
          _colorPathMapFromJSON(json['colorPathMap'] as Map<String, String>),
      category: _incomeCategoriesFromJSON((json['category'] as num).toInt()),
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$IncomeToJson(Income instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'imagePathMap': _imagePathMapToJSON(instance.imagePathMap),
      'colorPathMap': _colorPathMapToJSON(instance.colorPathMap),
      'category': _incomeCategoriesToJSON(instance.category),
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'time': instance.time.toIso8601String(),
    };
