import 'package:flutter/material.dart';
import 'package:showops/Views/Events/events.dart';
import 'package:showops/Views/Schedule/schedules.dart';
import 'package:showops/Views/Settings/settings.dart';

class CustomTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        EventsView(),
        SchedulesView(),
        SettingsView(),
      ],
    );
  }
}
