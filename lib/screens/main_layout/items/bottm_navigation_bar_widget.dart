import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/strings.dart';
import 'package:expenz/constants/values.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int Function(int) onItemTapped;
  final int selectedIndex;
  const BottomNavigationBarWidget({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        widget.onItemTapped(value);
      },
      currentIndex: widget.selectedIndex,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      unselectedItemColor: yBlackColor.withValues(
        alpha: 0.4,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.transparent,
      ),
      selectedLabelStyle: const TextStyle(
        color: yBlackColor,
      ),
      selectedItemColor: yBlueColor,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: yHome,
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.transcribe_outlined,
          ),
          label: yTransaction,
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(y100),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: yBlueColor,
            ),
            child: const Icon(
              Icons.add,
              color: yWhiteColor,
            ),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.bubble_chart,
          ),
          label: yHome,
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: yHome,
        )
      ],
    );
  }
}
