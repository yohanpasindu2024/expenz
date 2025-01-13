import 'package:expenz/screens/main_layout/items/bottm_navigation_bar_widget.dart';
import 'package:expenz/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    Provider.of<TransactionProvider>(context, listen: false)
        .fetchAllExpenses(context);
    Provider.of<TransactionProvider>(context, listen: false)
        .fetchAllIncomes(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBarWidget(
            onItemTapped: (value) {
              setState(() {
                provider.pageSelectionIndex = value;
              });
              return value;
            },
            selectedIndex: provider.pageSelectionIndex,
          ),
          body: provider.pages[provider.pageSelectionIndex],
        );
      },
    );
  }
}
