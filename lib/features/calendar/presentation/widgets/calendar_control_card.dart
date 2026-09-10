import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/calendar_controller.dart';

class CalendarControlCard extends ConsumerWidget {
  const CalendarControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarControllerProvider);
    final controller = ref.read(calendarControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month & View Switcher Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => controller.previousMonth(),
                    borderRadius: BorderRadius.circular(4),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.chevron_left, size: 20, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Mayo 2025',
                    style: AppTypography.headlineSm.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, size: 18, color: AppColors.onSurfaceVariant),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () => controller.nextMonth(),
                    borderRadius: BorderRadius.circular(4),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.chevron_right, size: 20, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Hoy',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => controller.toggleView(true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: state.isMonthView ? AppColors.primaryContainer : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Mes',
                              style: AppTypography.labelSm.copyWith(
                                color: state.isMonthView ? Colors.white : AppColors.onSurfaceVariant,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.toggleView(false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: !state.isMonthView ? AppColors.primaryContainer : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Semana',
                              style: AppTypography.labelSm.copyWith(
                                color: !state.isMonthView ? Colors.white : AppColors.onSurfaceVariant,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0x1A114036)),
          const SizedBox(height: 10),

          // Activity Tag Legend
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _LegendItem(color: AppColors.tertiaryFixedDim, label: 'Siembra'),
                const SizedBox(width: 12),
                _LegendItem(color: AppColors.secondary, label: 'Fertirrigación'),
                const SizedBox(width: 12),
                _LegendItem(color: AppColors.primaryContainer, label: 'Control de Calidad de Lote'),
                const SizedBox(width: 12),
                _LegendItem(color: const Color(0xFF59DCB5), label: 'Sensor de Suelo'),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Weekday Headers (L, M, X, J, V, S, D)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _WeekdayLabel('L'),
              _WeekdayLabel('M'),
              _WeekdayLabel('X'),
              _WeekdayLabel('J'),
              _WeekdayLabel('V'),
              _WeekdayLabel('S'),
              _WeekdayLabel('D'),
            ],
          ),
          const SizedBox(height: 8),

          // Calendar Grid for May 2025
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 35, // 5 weeks
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              // May 1 2025 is Thursday -> trailing 3 days in previous month (28, 29, 30)
              final int dayNumber = index - 2;
              final bool isCurrentMonth = dayNumber >= 1 && dayNumber <= 31;
              final bool isSelected = isCurrentMonth && dayNumber == state.selectedDate.day;

              if (!isCurrentMonth) {
                final int displayDay = dayNumber < 1 ? 27 + dayNumber + 3 : dayNumber - 31;
                return Center(
                  child: Text(
                    '$displayDay',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
                    ),
                  ),
                );
              }

              return InkWell(
                onTap: () {
                  controller.selectDate(DateTime(2025, 5, dayNumber));
                },
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondary : Colors.transparent,
                        shape: BoxShape.circle,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.secondary.withValues(alpha: 0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        '$dayNumber',
                        style: AppTypography.numericMetric.copyWith(
                          fontSize: 13,
                          color: isSelected ? Colors.white : AppColors.onSurface,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Activity Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (dayNumber == 1 || dayNumber == 6 || dayNumber == 13 || dayNumber == 14 || dayNumber == 20 || dayNumber == 26)
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (dayNumber == 2 || dayNumber == 8 || dayNumber == 14 || dayNumber == 19 || dayNumber == 28)
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: AppColors.tertiaryFixedDim,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (dayNumber == 5 || dayNumber == 9 || dayNumber == 14 || dayNumber == 22)
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.labelSm.copyWith(
            fontSize: 10,
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String text;

  const _WeekdayLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.labelMd.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
        fontSize: 11,
      ),
    );
  }
}
