import "package:flutter/material.dart";
import "package:tick_tock/core/types/navigator.dart";

class CustomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int index) onItemTapped;
  final List<NavBarItem> items;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    required this.items,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late final List<NavBarItem> _items = widget.items;

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => NavigationBar(
        onDestinationSelected: widget.onItemTapped,
        selectedIndex: widget.currentIndex,
        destinations: List.generate(
          _items.length,
          (final int index) => NavigationDestination(
            selectedIcon: Icon(_items[index].selectedIcon, size: 28),
            icon: Icon(_items[index].icon),
            label: _items[index].label,
          ),
        ),
      );
}
