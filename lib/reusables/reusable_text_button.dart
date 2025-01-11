import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class ReusableTextButton extends StatefulWidget {
  final Color? color;
  final String? text;
  final double? borderRadius;
  final void Function()? onTap;
  const ReusableTextButton({
    super.key,
    this.color,
    this.text,
    this.borderRadius,
    this.onTap,
  });

  @override
  State<ReusableTextButton> createState() => _ReusableTextButtonState();
}

class _ReusableTextButtonState extends State<ReusableTextButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 100),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 100),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            color: widget.color ?? yPurpleColor,
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? 100,
            ),
          ),
          child: Center(
            child: Text(
              widget.text ?? 'Next',
              style: TextStyle(
                fontSize: y150,
                color: yWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
