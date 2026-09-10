import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/daily_weather.dart';
import '../controllers/calendar_controller.dart';

class UpcomingWeatherList extends ConsumerWidget {
  const UpcomingWeatherList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarControllerProvider);
    final controller = ref.read(calendarControllerProvider.notifier);
    final upcoming = state.upcomingWeather;

    if (upcoming.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pronóstico de Otras Fechas',
                    style: AppTypography.headlineSm.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Selecciona una fecha para ver su comportamiento climático',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Horizontal scrolling cards for upcoming/other dates
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: upcoming.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final weather = upcoming[index];
              final isSelected = state.selectedDate.year == weather.date.year &&
                  state.selectedDate.month == weather.date.month &&
                  state.selectedDate.day == weather.date.day;

              return _UpcomingDayCard(
                weather: weather,
                isSelected: isSelected,
                onTap: () => controller.selectDate(weather.date),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _UpcomingDayCard extends StatelessWidget {
  final DailyWeather weather;
  final bool isSelected;
  final VoidCallback onTap;

  const _UpcomingDayCard({
    required this.weather,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasFrost = weather.hasFrostRisk;
    final dayLabel = _formatShortDate(weather.date);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 136,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surfaceContainerLowest
              : (hasFrost
                  ? const Color(0xFFF0F9FF)
                  : AppColors.surfaceContainerLowest),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.secondary
                : (hasFrost
                    ? const Color(0xFF0288D1).withValues(alpha: 0.4)
                    : AppColors.primary.withValues(alpha: 0.08)),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: (isSelected ? AppColors.secondary : Colors.black)
                  .withValues(alpha: isSelected ? 0.12 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Date header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    dayLabel,
                    style: AppTypography.labelSm.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.secondary : AppColors.primary,
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  weather.weatherIcon,
                  size: 16,
                  color: weather.indicatorColor,
                ),
              ],
            ),

            // Frost warning tag or Condition
            if (hasFrost)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE1F5FE),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.ac_unit, size: 10, color: Color(0xFF0288D1)),
                    const SizedBox(width: 2),
                    Text(
                      'Helada',
                      style: AppTypography.labelSm.copyWith(
                        fontSize: 9,
                        color: const Color(0xFF01579B),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            else
              Text(
                weather.condition,
                style: AppTypography.bodySm.copyWith(
                  fontSize: 10,
                  color: AppColors.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

            // Temperatures
            Row(
              children: [
                Text(
                  '${weather.tempMax.toStringAsFixed(0)}°',
                  style: AppTypography.labelMd.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '/ ${weather.tempMin.toStringAsFixed(0)}°',
                    style: AppTypography.bodySm.copyWith(
                      fontSize: 11,
                      color: AppColors.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Rain probability footer
            Row(
              children: [
                const Icon(Icons.water_drop, size: 10, color: Color(0xFF1976D2)),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    '${weather.rainProbability}% lluvia',
                    style: AppTypography.labelSm.copyWith(
                      fontSize: 9,
                      color: AppColors.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatShortDate(DateTime date) {
    const weekdays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    const months = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];
    final wd = weekdays[date.weekday - 1];
    final m = months[date.month - 1];
    return '$wd ${date.day} $m';
  }
}
