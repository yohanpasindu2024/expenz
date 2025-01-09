import 'package:expenz/screens/add_new_page/add_new_page.dart';
import 'package:expenz/screens/buget_page/budget_page.dart';
import 'package:expenz/screens/home_page/home_page.dart';
import 'package:expenz/screens/main_layout/items/bottm_navigation_bar_widget.dart';
import 'package:expenz/screens/profile_page/profile_page.dart';
import 'package:expenz/screens/transcation_page/transcation_page.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {

  const MainLayout({
    super.key,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  late final List<Widget> mainLayoutPages;

  @override
  void initState() {
    mainLayoutPages = <Widget>[
      HomePage(),
      TranscationPage(),
      AddNewPage(),
      BudgetPage(),
      ProfilePage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        onItemTapped: (value) {
          setState(() {
            _selectedIndex = value;
          });
          return value;
        },
        selectedIndex: _selectedIndex,
      ),
      body: mainLayoutPages[2],
    );
  }
}
