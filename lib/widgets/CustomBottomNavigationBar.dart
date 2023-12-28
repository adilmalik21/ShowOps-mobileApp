import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final ValueNotifier<int> tabIndex;

  CustomBottomNavigationBar({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: const [
        Tab(icon: Icon(Icons.event), text: "Events"),
        Tab(icon: Icon(Icons.schedule), text: "Schedule"),
        Tab(icon: Icon(Icons.settings), text: "Settings"),
      ],
      labelColor: Color(0xff9dc451),
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Color(0xff9dc451),
      onTap: (index) {
        // Update the tabIndex ValueNotifier on tab change
        tabIndex.value = index;
      },
    );
  }
}
