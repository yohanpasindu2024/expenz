import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class OnboardingContainer extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  const OnboardingContainer({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: y600,
        right: y600,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 280,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          SizedBox(
            height: y500,
          ),
          Text(
            title,
            style: TextStyle(
              color: yBlackColor,
              fontWeight: FontWeight.w600,
              fontSize: y250,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: y100,
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: yBlackColor.withValues(
                alpha: 0.8,
              ),
              fontWeight: FontWeight.w400,
              fontSize: y150,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
