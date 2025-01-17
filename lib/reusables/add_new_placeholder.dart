import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class AddNewPlaceholder extends StatefulWidget {
  final void Function() toAddNewPage;
  const AddNewPlaceholder({
    super.key,
    required this.toAddNewPage,
  });

  @override
  State<AddNewPlaceholder> createState() => _AddNewPlaceholderState();
}

class _AddNewPlaceholderState extends State<AddNewPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Add new to continue",
            style: TextStyle(
              color: yBlackColor.withValues(alpha: 0.3),
              fontSize: y200,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: y150,
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: yGreyColor,
              borderRadius: BorderRadius.circular(y600),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  widget.toAddNewPage();
                },
                icon: Icon(
                  Icons.add,
                  color: yWhiteColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
