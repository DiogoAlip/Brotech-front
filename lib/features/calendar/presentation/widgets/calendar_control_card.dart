import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/calendar_controller.dart';

const List<String> kSpanishMonthNames = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre',
];

const List<String> kSpanishMonthShortNames = [
  'Ene',
  'Feb',
  'Mar',
  'Abr',
  'May',
  'Jun',
  'Jul',
  'Ago',
  'Sep',
  'Oct',
  'Nov',
  'Dic',
];

class CalendarControlCard extends ConsumerWidget {
  const CalendarControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarControllerProvider);
    final controller = ref.read(calendarControllerProvider.notifier);

    final currentMonthName = kSpanishMonthNames[state.selectedDate.month - 1];

    return Container(
      padding: const EdgeInsets.all(12),
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
              // Month/Year navigation and toggle
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => controller.previousMonth(),
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.chevron_left,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Flexible(
                      child: InkWell(
                        onTap: () => controller.toggleMonthYearSelector(),
                        borderRadius: BorderRadius.circular(6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  '$currentMonthName ${state.selectedDate.year}',
                                  style: AppTypography.headlineSm.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Icon(
                                state.isSelectingMonthYear
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                size: 18,
                                color: AppColors.secondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    InkWell(
                      onTap: () => controller.nextMonth(),
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Today button and Month/Week toggle
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => controller.goToToday(),
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (state.isSelectingMonthYear) {
                              controller.toggleMonthYearSelector(false);
                            }
                            controller.toggleView(true);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: state.isMonthView && !state.isSelectingMonthYear
                                  ? AppColors.primaryContainer
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Mes',
                              style: AppTypography.labelSm.copyWith(
                                color: state.isMonthView && !state.isSelectingMonthYear
                                    ? Colors.white
                                    : AppColors.onSurfaceVariant,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (state.isSelectingMonthYear) {
                              controller.toggleMonthYearSelector(false);
                            }
                            controller.toggleView(false);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: !state.isMonthView && !state.isSelectingMonthYear
                                  ? AppColors.primaryContainer
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Semana',
                              style: AppTypography.labelSm.copyWith(
                                color: !state.isMonthView && !state.isSelectingMonthYear
                                    ? Colors.white
                                    : AppColors.onSurfaceVariant,
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
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0x1A114036)),
          const SizedBox(height: 8),

          // Main Body: Either Month/Year Selector OR Calendar Grid
          if (state.isSelectingMonthYear)
            _MonthYearSelectorView(
              viewingYear: state.viewingYear,
              selectedDate: state.selectedDate,
              onSelectMonth: (month) => controller.selectMonth(month),
              onSetYear: (year) => controller.setViewingYear(year),
              onPreviousYear: () => controller.previousYear(),
              onNextYear: () => controller.nextYear(),
              onClose: () => controller.toggleMonthYearSelector(false),
            )
          else ...[
            // Activity Tag Legend
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _LegendItem(color: AppColors.tertiaryFixedDim, label: 'Siembra'),
                  SizedBox(width: 12),
                  _LegendItem(color: AppColors.secondary, label: 'Fertirrigación'),
                  SizedBox(width: 12),
                  _LegendItem(color: AppColors.primaryContainer, label: 'Control de Calidad'),
                  SizedBox(width: 12),
                  _LegendItem(color: Color(0xFF59DCB5), label: 'Sensor de Suelo'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Weekday Headers (L, M, X, J, V, S, D)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _WeekdayLabel('L'),
                _WeekdayLabel('M'),
                _WeekdayLabel('X'),
                _WeekdayLabel('J'),
                _WeekdayLabel('V'),
                _WeekdayLabel('S'),
                _WeekdayLabel('D'),
              ],
            ),
            const SizedBox(height: 6),

            // Calendar Grid (Month or Week view)
            if (state.isMonthView)
              _DynamicMonthGrid(
                selectedDate: state.selectedDate,
                hasTasksOnDate: (date) => controller.hasTasksOnDate(date),
                onDateSelected: (date) => controller.selectDate(date),
              )
            else
              _WeekDaysRow(
                selectedDate: state.selectedDate,
                hasTasksOnDate: (date) => controller.hasTasksOnDate(date),
                onDateSelected: (date) => controller.selectDate(date),
              ),
          ],
        ],
      ),
    );
  }
}

/// Interactive Month & Year selection panel
class _MonthYearSelectorView extends StatelessWidget {
  final int viewingYear;
  final DateTime selectedDate;
  final ValueChanged<int> onSelectMonth;
  final ValueChanged<int> onSetYear;
  final VoidCallback onPreviousYear;
  final VoidCallback onNextYear;
  final VoidCallback onClose;

  const _MonthYearSelectorView({
    required this.viewingYear,
    required this.selectedDate,
    required this.onSelectMonth,
    required this.onSetYear,
    required this.onPreviousYear,
    required this.onNextYear,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Year Navigation & Dropdown selector
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onPreviousYear,
                  icon: const Icon(Icons.chevron_left, size: 20, color: AppColors.primary),
                  tooltip: 'Año anterior',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                ),
                // Clickable year dropdown menu
                PopupMenuButton<int>(
                  tooltip: 'Elegir año',
                  initialValue: viewingYear,
                  onSelected: onSetYear,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  itemBuilder: (context) {
                    const startYear = 2020;
                    const endYear = 2035;
                    return List.generate(endYear - startYear + 1, (i) {
                      final year = startYear + i;
                      return PopupMenuItem<int>(
                        value: year,
                        child: Text(
                          '$year',
                          style: AppTypography.labelMd.copyWith(
                            fontWeight: year == viewingYear ? FontWeight.w700 : FontWeight.w500,
                            color: year == viewingYear ? AppColors.secondary : AppColors.onSurface,
                          ),
                        ),
                      );
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calendar_today, size: 12, color: AppColors.secondary),
                        const SizedBox(width: 4),
                        Text(
                          '$viewingYear',
                          style: AppTypography.labelLg.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, size: 16, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onNextYear,
                  icon: const Icon(Icons.chevron_right, size: 20, color: AppColors.primary),
                  tooltip: 'Año siguiente',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                ),
              ],
            ),
            // Button to return to day calendar
            TextButton.icon(
              onPressed: onClose,
              icon: const Icon(Icons.check, size: 14, color: AppColors.secondary),
              label: Text(
                'Listo',
                style: AppTypography.labelSm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondary,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // 12 Months Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.8,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
          ),
          itemBuilder: (context, index) {
            final monthNumber = index + 1;
            final isSelected = selectedDate.month == monthNumber && selectedDate.year == viewingYear;
            final isCurrentRealMonth = now.month == monthNumber && now.year == viewingYear;

            return InkWell(
              onTap: () => onSelectMonth(monthNumber),
              borderRadius: BorderRadius.circular(6),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.secondary
                      : isCurrentRealMonth
                          ? AppColors.secondary.withValues(alpha: 0.1)
                          : AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.secondary
                        : isCurrentRealMonth
                            ? AppColors.secondary.withValues(alpha: 0.5)
                            : AppColors.primary.withValues(alpha: 0.08),
                    width: isSelected || isCurrentRealMonth ? 1.5 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.secondary.withValues(alpha: 0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  kSpanishMonthShortNames[index],
                  style: AppTypography.labelMd.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : isCurrentRealMonth
                            ? AppColors.secondary
                            : AppColors.onSurface,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Dynamic Month Grid calculating correct weekday offsets, previous/next month days, and tasks
class _DynamicMonthGrid extends StatelessWidget {
  final DateTime selectedDate;
  final bool Function(DateTime date) hasTasksOnDate;
  final ValueChanged<DateTime> onDateSelected;

  const _DynamicMonthGrid({
    required this.selectedDate,
    required this.hasTasksOnDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final year = selectedDate.year;
    final month = selectedDate.month;

    final daysInMonth = DateTime(year, month + 1, 0).day;
    final daysInPrevMonth = DateTime(year, month, 0).day;
    final firstWeekday = DateTime(year, month, 1).weekday; // 1 = Monday ... 7 = Sunday
    final leadingOffset = firstWeekday - 1; // 0 if Monday, 6 if Sunday

    final totalDays = leadingOffset + daysInMonth;
    final totalCells = totalDays <= 35 ? 35 : 42;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalCells,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final int dayNumber;
        final bool isCurrentMonth;
        final DateTime cellDate;

        if (index < leadingOffset) {
          final prevDay = daysInPrevMonth - leadingOffset + 1 + index;
          final prevMonth = month == 1 ? 12 : month - 1;
          final prevYear = month == 1 ? year - 1 : year;
          cellDate = DateTime(prevYear, prevMonth, prevDay);
          dayNumber = prevDay;
          isCurrentMonth = false;
        } else if (index < leadingOffset + daysInMonth) {
          dayNumber = index - leadingOffset + 1;
          cellDate = DateTime(year, month, dayNumber);
          isCurrentMonth = true;
        } else {
          final nextDay = index - (leadingOffset + daysInMonth) + 1;
          final nextMonth = month == 12 ? 1 : month + 1;
          final nextYear = month == 12 ? year + 1 : year;
          cellDate = DateTime(nextYear, nextMonth, nextDay);
          dayNumber = nextDay;
          isCurrentMonth = false;
        }

        final bool isSelected = isCurrentMonth &&
            selectedDate.year == cellDate.year &&
            selectedDate.month == cellDate.month &&
            selectedDate.day == cellDate.day;

        if (!isCurrentMonth) {
          return InkWell(
            onTap: () => onDateSelected(cellDate),
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: Text(
                '$dayNumber',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.35),
                ),
              ),
            ),
          );
        }

        return InkWell(
          onTap: () => onDateSelected(cellDate),
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
                  if (hasTasksOnDate(cellDate)) ...[
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: const BoxDecoration(
                        color: AppColors.tertiaryFixedDim,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Week Days Row displayed when Week View is toggled
class _WeekDaysRow extends StatelessWidget {
  final DateTime selectedDate;
  final bool Function(DateTime date) hasTasksOnDate;
  final ValueChanged<DateTime> onDateSelected;

  const _WeekDaysRow({
    required this.selectedDate,
    required this.hasTasksOnDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Determine Monday of the current selected week
    final monday = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 7,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final cellDate = monday.add(Duration(days: index));
        final isSelected = cellDate.year == selectedDate.year &&
            cellDate.month == selectedDate.month &&
            cellDate.day == selectedDate.day;

        return InkWell(
          onTap: () => onDateSelected(cellDate),
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
                  '${cellDate.day}',
                  style: AppTypography.numericMetric.copyWith(
                    fontSize: 13,
                    color: isSelected ? Colors.white : AppColors.onSurface,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              // Activity Dot
              if (hasTasksOnDate(cellDate))
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.secondary : AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        );
      },
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
