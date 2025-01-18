import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String actionLabel;
  final void Function() action;
  const ActionCard({
    super.key,
    required this.color,
    required this.icon,
    required this.actionLabel,
    required this.action,
  });

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: y100),
      decoration: BoxDecoration(
        color: yWhiteColor,
        borderRadius: BorderRadius.circular(y100),
        boxShadow: [
          BoxShadow(
            color: yGreyColor,
            offset: Offset(0, 2),
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: y150, vertical: y100),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  widget.action();
                },
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(y100),
                    border: Border.all(
                      color: widget.color.withValues(alpha: 0.6),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      widget.icon,
                      color: widget.color.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            widget.actionLabel,
            style: TextStyle(
              color: yBlackColor.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
