import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  final void Function() yes;
  final void Function() no;
  const BottomSheetWidget({
    super.key,
    required this.yes,
    required this.no,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: yBlueColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: y250,
          horizontal: y300,
        ),
        child: Column(
          children: [
            Text(
              "Logout?",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: yBlackColor.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "are you sure do you wanna logout?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: yBlackColor.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      widget.no();
                    },
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      height: 46,
                      width: MediaQuery.of(context).size.width * 0.356,
                      decoration: BoxDecoration(
                        color: yBlueColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          yNo,
                          style: TextStyle(
                            color: yGreyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      widget.yes();
                    },
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.356,
                      child: Center(
                        child: Text(
                          yYes,
                          style: TextStyle(
                            color: yBlackColor.withValues(
                              alpha: 0.7,
                            ),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
