import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

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
  final String? priority;

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
    this.priority,
  });

  CalendarTask copyWith({
    String? id,
    String? time,
    String? title,
    String? subtitle,
    String? category,
    Color? categoryColor,
    IconData? categoryIcon,
    String? status,
    Color? statusBgColor,
    Color? statusTextColor,
    String? metric1Label,
    IconData? metric1Icon,
    String? metric2Label,
    IconData? metric2Icon,
    bool? isInProgress,
    String? priority,
  }) {
    return CalendarTask(
      id: id ?? this.id,
      time: time ?? this.time,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      category: category ?? this.category,
      categoryColor: categoryColor ?? this.categoryColor,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      status: status ?? this.status,
      statusBgColor: statusBgColor ?? this.statusBgColor,
      statusTextColor: statusTextColor ?? this.statusTextColor,
      metric1Label: metric1Label ?? this.metric1Label,
      metric1Icon: metric1Icon ?? this.metric1Icon,
      metric2Label: metric2Label ?? this.metric2Label,
      metric2Icon: metric2Icon ?? this.metric2Icon,
      isInProgress: isInProgress ?? this.isInProgress,
      priority: priority ?? this.priority,
    );
  }

  CalendarTask advanceStatus() {
    if (status == 'Programado') {
      return copyWith(
        status: 'En Curso',
        statusBgColor: const Color(0x3375F6CE),
        statusTextColor: const Color(0xFF007058),
        isInProgress: true,
      );
    } else if (status == 'En Curso') {
      return copyWith(
        status: 'Completado',
        statusBgColor: const Color(0xFFE8F5E9),
        statusTextColor: const Color(0xFF006B54),
        isInProgress: false,
      );
    } else {
      return this;
    }
  }

  CalendarTask regressStatus() {
    if (status == 'Completado') {
      return copyWith(
        status: 'En Curso',
        statusBgColor: const Color(0x3375F6CE),
        statusTextColor: const Color(0xFF007058),
        isInProgress: true,
      );
    } else if (status == 'En Curso') {
      return copyWith(
        status: 'Programado',
        statusBgColor: AppColors.surfaceContainer,
        statusTextColor: AppColors.onSurfaceVariant,
        isInProgress: false,
      );
    } else {
      return this;
    }
  }
}
