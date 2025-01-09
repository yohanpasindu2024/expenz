import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class FreeTextField extends StatefulWidget {
  const FreeTextField({super.key});

  @override
  State<FreeTextField> createState() => _FreeTextFieldState();
}

class _FreeTextFieldState extends State<FreeTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.15,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: y150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$yHowMuch$yQuestionMark",
              style: TextStyle(
                fontSize: y200 - 5,
                color: yWhiteColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: y500,
                color: yWhiteColor,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: TextStyle(
                  fontSize: y500,
                  color: yWhiteColor,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
              ),
              cursorColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
