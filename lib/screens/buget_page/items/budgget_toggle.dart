import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class BudggetToggle extends StatefulWidget {
  final void Function(bool) onTap;
  const BudggetToggle({
    super.key,
    required this.onTap,
  });

  @override
  State<BudggetToggle> createState() => _BudggetToggleState();
}

class _BudggetToggleState extends State<BudggetToggle> {
  bool pageState = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: yGreyColor,
        borderRadius: BorderRadius.circular(y400),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: pageState
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: yBlueColor,
                      borderRadius: BorderRadius.circular(y400),
                    ),
                    child: Center(
                      child: Text(
                        yIncome,
                        style: TextStyle(
                          fontSize: y150 + 1,
                          fontWeight: FontWeight.w600,
                          color: yWhiteColor,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          pageState = !pageState;
                          widget.onTap(pageState);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: y400),
                        child: Text(
                          yExpense,
                          style: TextStyle(
                            fontSize: y150,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          pageState = !pageState;
                          widget.onTap(pageState);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: y400),
                        child: Text(
                          yIncome,
                          style: TextStyle(
                            fontSize: y150,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: yBlueColor,
                      borderRadius: BorderRadius.circular(y400),
                    ),
                    child: Center(
                      child: Text(
                        yExpense,
                        style: TextStyle(
                          fontSize: y150 + 1,
                          fontWeight: FontWeight.w600,
                          color: yWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
