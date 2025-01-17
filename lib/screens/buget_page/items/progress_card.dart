import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class ProgressCard extends StatefulWidget {
  final String category;
  final double width;
  final Color color;
  final String value;
  final Color valueColor;
  const ProgressCard({
    super.key,
    required this.category,
    required this.width,
    required this.color,
    required this.value,
    required this.valueColor,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: y250),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: yGreyColor.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(y300),
                  border: Border.all(
                    color: yGreyColor,
                    width: 0.8,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: y25,
                    horizontal: y200,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(y300),
                        ),
                      ),
                      SizedBox(
                        width: y150 + 2,
                      ),
                      Text(
                        widget.category,
                        style: TextStyle(
                          fontSize: y150,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                widget.value,
                style: TextStyle(
                  fontSize: y200 + 1,
                  color: widget.valueColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: y100,
          ),
          LinearProgressIndicator(
            backgroundColor: yGreyColor,
            borderRadius: BorderRadius.circular(y300),
            value: widget.width,
            minHeight: y200 - 5,
            valueColor: AlwaysStoppedAnimation<Color?>(widget.valueColor),
          ),
        ],
      ),
    );
  }
}
