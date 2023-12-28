import 'package:flutter/material.dart';
import 'package:showops/widgets/CustomAppBar.dart';
import 'package:showops/widgets/CustomBottomNavigationBar.dart';
import 'package:showops/widgets/CustomTabBarView.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(tabIndex: _tabIndex),
            body: CustomTabBarView(), // Use the CustomTabBarView
            bottomNavigationBar: CustomBottomNavigationBar(
                tabIndex: _tabIndex), // Use the CustomBottomNavigationBar
          ),
        ),
      ),
    );
  }
}
