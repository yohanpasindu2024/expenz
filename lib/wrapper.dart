import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:expenz/screens/main_layout/main_layout.dart';
import 'package:expenz/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  final bool isHomePageShow;
  const Wrapper({
    super.key,
    required this.isHomePageShow,
  });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: yAppName,
      theme: ThemeData(
        fontFamily: "Inter",
        buttonTheme: ButtonThemeData(
          buttonColor: yBlueColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              yBorderRadius200,
            ),
          ),
        ),
        scaffoldBackgroundColor: yWhiteColor,
        primaryColor: yBlueColor,
        iconTheme: IconThemeData(
          color: yBlueColor,
          size: y300,
        ),
      ),
      home: widget.isHomePageShow ? MainLayout() : const OnBoardingScreen(),
    );
  }
}
