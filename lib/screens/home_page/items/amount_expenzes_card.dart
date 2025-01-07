import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class IncomeExpenzesCard extends StatefulWidget {
  final String title;
  final String amount;
  final String imgagePath;
  final Color color;
  const IncomeExpenzesCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.imgagePath,
  });

  @override
  State<IncomeExpenzesCard> createState() => _IncomeExpenzesCardState();
}

class _IncomeExpenzesCardState extends State<IncomeExpenzesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.41,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(
          y250,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.color.withValues(
              alpha: 0.5,
            ),
            blurRadius: y25,
            offset: Offset(
              y25,
              y25,
            ),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: y100,
          vertical: y150,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.13,
              decoration: BoxDecoration(
                color: yWhiteColor,
                borderRadius: BorderRadius.circular(y100),
              ),
              child: Center(
                child: Image.asset(
                  widget.imgagePath,
                ),
              ),
            ),
            SizedBox(
              width: y25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: yWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: y100 - 9,
                ),
                Text(
                  widget.amount,
                  style: TextStyle(
                    color: yWhiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: y200,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
