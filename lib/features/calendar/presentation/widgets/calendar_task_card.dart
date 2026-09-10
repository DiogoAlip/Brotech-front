import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/calendar_task.dart';

class CalendarTaskCard extends StatelessWidget {
  final CalendarTask task;

  const CalendarTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Colored Accent Line
            Container(
              width: 5,
              color: task.categoryColor,
            ),
            // Card Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar: Time, Category Pill, Status Badge
                    // Top Bar: Time, Category Pill, Priority, Status Badge
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                task.time,
                                style: AppTypography.numericMetric.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: task.categoryColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(task.categoryIcon, size: 12, color: task.categoryColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    task.category,
                                    style: AppTypography.labelSm.copyWith(
                                      color: task.categoryColor == AppColors.tertiaryFixedDim
                                          ? AppColors.tertiary
                                          : task.categoryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Priority and Status Badges
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (task.priority != null && task.priority!.isNotEmpty) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getPriorityBg(task.priority!),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: _getPriorityBorder(task.priority!), width: 0.8),
                                ),
                                child: Text(
                                  task.priority!,
                                  style: AppTypography.labelSm.copyWith(
                                    color: _getPriorityColor(task.priority!),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                            ],
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: task.statusBgColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (task.isInProgress) ...[
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: AppColors.secondary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                  ],
                                  Text(
                                    task.status,
                                    style: AppTypography.labelSm.copyWith(
                                      color: task.statusTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Title & Botanical Subtitle
                    Text(
                      task.title,
                      style: AppTypography.headlineSm.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.subtitle,
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Metric Chips Row
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _SpecChip(icon: task.metric1Icon, label: task.metric1Label),
                        _SpecChip(icon: task.metric2Icon, label: task.metric2Label),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SpecChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.secondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.labelSm.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

Color _getPriorityColor(String priority) {
  switch (priority.toLowerCase()) {
    case 'alta':
      return const Color(0xFFBA1A1A);
    case 'media':
      return const Color(0xFFB87800);
    case 'baja':
    default:
      return AppColors.secondary;
  }
}

Color _getPriorityBg(String priority) {
  switch (priority.toLowerCase()) {
    case 'alta':
      return const Color(0xFFFFDAD6);
    case 'media':
      return const Color(0xFFFFF3D6);
    case 'baja':
    default:
      return const Color(0xFFE0F7EF);
  }
}

Color _getPriorityBorder(String priority) {
  switch (priority.toLowerCase()) {
    case 'alta':
      return const Color(0xFFFFB4AB);
    case 'media':
      return const Color(0xFFFFDEAD);
    case 'baja':
    default:
      return const Color(0xFFA2D0C2);
  }
}
