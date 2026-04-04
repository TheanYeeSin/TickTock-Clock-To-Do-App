import "package:flutter/material.dart";
import "package:tick_tock/core/constants/path.dart";
import "package:tick_tock/core/types/navigator.dart";
import "package:tick_tock/features/more/presentation/screens/more_screen.dart";
import "package:tick_tock/presentation/screens/main_screen.dart";
import "package:tick_tock/presentation/widgets/custom_nav_bar.dart";

class MainNavigatorScreen extends StatefulWidget {
  const MainNavigatorScreen({super.key});

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  // ----- Index handling -----
  int _currentIndex = 0;
  void _onItemTapped(final int index) => setState(() => _currentIndex = index);

  // ----- Navigation Bar Items -----
  final _items = [
    NavBarItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: "Home",
      path: homePath,
      screen: const MainScreen(),
    ),
    NavBarItem(
      icon: Icons.more_horiz_outlined,
      selectedIcon: Icons.more_horiz_rounded,
      label: "More",
      path: morePath,
      screen: const MoreScreen(),
    ),
  ];

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => Scaffold(
        body: _items[_currentIndex].screen,
        bottomNavigationBar: CustomNavBar(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
          items: _items,
        ),
      );
}
