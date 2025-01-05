import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class ReusableTextButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final double? borderRadius;
  const ReusableTextButton({
    super.key,
    this.color,
    this.text,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: color ?? yPurpleColor,
        borderRadius: BorderRadius.circular(
          borderRadius ?? 100,
        ),
      ),
      child: Center(
        child: Text(
          text ?? 'Next',
          style: TextStyle(
            fontSize: y150,
            color: yWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
