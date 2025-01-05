import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EXpenzApp());
}

class EXpenzApp extends StatelessWidget {
  const EXpenzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: yAppName,
      theme: ThemeData(
        fontFamily: "Inter",
        buttonTheme: ButtonThemeData(
          buttonColor: yPurpleColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              yBorderRadius200,
            ),
          ),
        ),
        scaffoldBackgroundColor: yWhiteColor,
        primaryColor: yPurpleColor,
        iconTheme: IconThemeData(
          color: yPurpleColor,
          size: y300,
        ),
      ),
      home: const OnBoardingScreen(),
    );
  }
}
