import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class ToggleHeader extends StatefulWidget {
  final void Function(Color, int) onToggle;
  const ToggleHeader({
    super.key,
    required this.onToggle,
  });

  @override
  State<ToggleHeader> createState() => _ToggleHeaderState();
}

class _ToggleHeaderState extends State<ToggleHeader> {
  bool _activeExpenses = false;
  bool _activeIncome = true;
  Color _color = yGreenColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: yWhiteColor,
        borderRadius: BorderRadius.circular(
          y400,
        ),
      ),
      child: Row(
        mainAxisAlignment:
            _activeIncome ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: y50,
              horizontal: y50,
            ),
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  y400,
                ),
              ),
              clipBehavior: Clip.none,
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  y400,
                ),
                onTap: () {
                  setState(() {
                    _activeIncome = true;
                    _activeExpenses = false;
                    _color = yGreenColor;
                    widget.onToggle(yGreenColor, 0);
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.43,
                  decoration: BoxDecoration(
                    color: _activeIncome ? _color : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      y400,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      yIncome,
                      style: TextStyle(
                        color: _activeIncome ? yWhiteColor : yBlackColor,
                        fontWeight:
                            _activeIncome ? FontWeight.w600 : FontWeight.w500,
                        fontSize: _activeIncome ? y150 + 1 : y150,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: y50,
              horizontal: y50,
            ),
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  y400,
                ),
              ),
              clipBehavior: Clip.none,
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  y400,
                ),
                onTap: () {
                  setState(() {
                    _activeExpenses = true;
                    _activeIncome = false;
                    _color = yOrangeColor;
                    widget.onToggle(yOrangeColor, 1);
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.43,
                  decoration: BoxDecoration(
                    color: _activeExpenses ? _color : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      200,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      yExpense,
                      style: TextStyle(
                        color: _activeExpenses ? yWhiteColor : yBlackColor,
                        fontWeight:
                            _activeExpenses ? FontWeight.w600 : FontWeight.w500,
                        fontSize: _activeExpenses ? y150 + 1 : y150,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
