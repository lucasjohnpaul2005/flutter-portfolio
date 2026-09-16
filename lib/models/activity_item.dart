import 'package:flutter/material.dart';

/// Plain data model - no logic, no state.
/// Keeping this separate from the widgets keeps the UI layer "dumb"
/// and makes it trivial to add new activities as your course progresses.
class ActivityItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String routeName;
  final Color color;

  const ActivityItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.routeName,
    required this.color,
  });
}
