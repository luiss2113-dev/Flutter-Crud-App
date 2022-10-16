import 'package:flutter/material.dart' show IconData, Widget;

class ScreenOption {
  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  ScreenOption(
      {required this.route,
      required this.icon,
      required this.name,
      required this.screen});
}
