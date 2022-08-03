import 'package:budget_tracker/model/add_budget_dialog.dart';
import 'package:budget_tracker/services/budget_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../services/theme_service.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(themeService.darkTheme ? Icons.sunny : Icons.dark_mode),
          onPressed: () {
            themeService.darkTheme = !themeService.darkTheme;
          },
        ),
        title: const Text('Budget Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet_rounded),
            tooltip: 'Add your balance',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddBudgetDialog(
                      budgetToAdd: (budget) {
                        final budgetService =
                            Provider.of<BudgetService>(context, listen: false);
                        budgetService.budget = budget;
                      },
                    );
                  });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: bottomNavItems,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      body: pages[_currentPageIndex],
    );
  }
}
