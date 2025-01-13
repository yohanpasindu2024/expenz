import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/logics.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class IncomeExpenseDisplayCard extends StatefulWidget {
  final Color containerColor;
  final Color amountColor;
  final String imagePath;
  final String title;
  final String description;
  final String amount;
  final String time;
  const IncomeExpenseDisplayCard({
    super.key,
    required this.containerColor,
    required this.amountColor,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.amount,
    required this.time,
  });

  @override
  State<IncomeExpenseDisplayCard> createState() =>
      _IncomeExpenseDisplayCardState();
}

class _IncomeExpenseDisplayCardState extends State<IncomeExpenseDisplayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: y100,
      ),
      decoration: BoxDecoration(
        color: yGreyColor,
        borderRadius: BorderRadius.circular(
          y150,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          y100,
        ),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.18,
              decoration: BoxDecoration(
                color: widget.containerColor.withValues(
                  alpha: 0.4,
                ),
                borderRadius: BorderRadius.circular(
                  y150,
                ),
              ),
              child: Center(
                child: Image.asset(
                  widget.imagePath,
                  width: MediaQuery.of(context).size.width * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: y100,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: y150 + 2,
                        ),
                      ),
                      SizedBox(
                        height: y100,
                      ),
                      Text(
                        truncateString(widget.description),
                        style: TextStyle(
                          color: yBlackColor.withValues(
                            alpha: 0.6,
                          ),
                          fontSize: y100 + 2,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.amount,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: y150 + 1,
                          color: widget.amountColor,
                        ),
                      ),
                      SizedBox(
                        height: y100,
                      ),
                      Text(
                        widget.time,
                        style: TextStyle(
                          color: yBlackColor.withValues(
                            alpha: 0.6,
                          ),
                          fontSize: y150 + 2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
