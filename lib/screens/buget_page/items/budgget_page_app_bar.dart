import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class BuggutPageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BuggutPageAppBar({super.key});

  @override
  State<BuggutPageAppBar> createState() => _BuggutPageAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _BuggutPageAppBarState extends State<BuggutPageAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        yFinancialReport,
        style: TextStyle(
          fontSize: y200,
        ),
      ),
      backgroundColor: yWhiteColor,
      actions: [
        IconButton(
          onPressed: () {/* Notification Button */},
          icon: Icon(
            Icons.notifications,
            color: yBlackColor.withValues(alpha: 0.7),
          ),
        )
      ],
    );
  }
}
