import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class PickerReusable extends StatefulWidget {
  final void Function() onTap;
  final String buttonText;
  final String outPutText;
  final Color color;
  final IconData icon;
  const PickerReusable({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.outPutText,
    required this.color,
    required this.icon,
  });

  @override
  State<PickerReusable> createState() => _PickerReusableState();
}

class _PickerReusableState extends State<PickerReusable> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              y500,
            ),
          ),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(
              y500,
            ),
            child: getSelectButton(
              label: widget.buttonText,
              color: widget.color,
              icon: widget.icon,
            ),
          ),
        ),
        Text(
          widget.outPutText,
          style: TextStyle(
            color: yBlackColor.withValues(
              alpha: 0.5,
            ),
          ),
          textAlign: TextAlign.end,
          softWrap: true,
        ),
      ],
    );
  }

  Widget getSelectButton({
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.063,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          y500,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: y200,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: yWhiteColor,
              size: y250,
            ),
            SizedBox(
              width: y150,
            ),
            Text(
              label,
              style: TextStyle(
                color: yWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
