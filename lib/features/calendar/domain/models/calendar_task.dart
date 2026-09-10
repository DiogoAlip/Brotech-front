import 'package:flutter/material.dart';

class CalendarTask {
  final String id;
  final String time;
  final String title;
  final String subtitle;
  final String category;
  final Color categoryColor;
  final IconData categoryIcon;
  final String status;
  final Color statusBgColor;
  final Color statusTextColor;
  final String metric1Label;
  final IconData metric1Icon;
  final String metric2Label;
  final IconData metric2Icon;
  final bool isInProgress;

  const CalendarTask({
    required this.id,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.categoryColor,
    required this.categoryIcon,
    required this.status,
    required this.statusBgColor,
    required this.statusTextColor,
    required this.metric1Label,
    required this.metric1Icon,
    required this.metric2Label,
    required this.metric2Icon,
    this.isInProgress = false,
  });
}
