import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/screens/add_new_page/items/expense_incom_input_form.dart';
import 'package:flutter/material.dart';

class TextFieldReusable extends StatefulWidget {
  final AddNewTextFieldType type;
  final TextEditingController controller;
  final InputDecoration inputDecoration;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final Color color;
  const TextFieldReusable({
    super.key,
    required this.type,
    required this.controller,
    required this.inputDecoration,
    this.inputAction = TextInputAction.next,
    required this.color,
    this.inputType = TextInputType.text,
  });

  @override
  State<TextFieldReusable> createState() => _TextFieldReusableState();
}

class _TextFieldReusableState extends State<TextFieldReusable> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: widget.color,
      // autofocus: true, // * Autofocus the text field
      textInputAction: widget.inputAction,
      cursorOpacityAnimates: true,
      cursorHeight: y200,
      style: TextStyle(
        color: yBlackColor.withValues(
          alpha: 0.8,
        ),
        fontWeight: FontWeight.w500,
      ),
      decoration: widget.inputDecoration,
      keyboardType: widget.inputType,
    );
  }
}
