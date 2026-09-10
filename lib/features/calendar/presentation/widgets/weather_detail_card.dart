import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/daily_weather.dart';

class WeatherDetailCard extends StatelessWidget {
  final DailyWeather weather;

  const WeatherDetailCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final hasFrost = weather.hasFrostRisk;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: hasFrost
              ? const Color(0xFF0288D1).withValues(alpha: 0.3)
              : AppColors.primary.withValues(alpha: 0.08),
          width: hasFrost ? 1.2 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: (hasFrost ? const Color(0xFF0288D1) : AppColors.primary)
                .withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Date & Condition Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDateHeader(weather.date),
                      style: AppTypography.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Pronóstico Agrometeorológico • Finca El Roble',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: hasFrost
                      ? const Color(0xFFE1F5FE)
                      : weather.conditionCategory == 'lluvia'
                          ? const Color(0xFFE3F2FD)
                          : AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      weather.weatherIcon,
                      size: 13,
                      color: weather.indicatorColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      hasFrost ? 'Riesgo Helada' : weather.condition,
                      style: AppTypography.labelSm.copyWith(
                        color: weather.indicatorColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Main Hero Temperature Row
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: hasFrost
                  ? const Color(0xFFF0F9FF)
                  : AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: hasFrost
                    ? const Color(0xFF0288D1).withValues(alpha: 0.2)
                    : AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: weather.indicatorColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    weather.weatherIcon,
                    color: weather.indicatorColor,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 6,
                        runSpacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '${weather.currentTemp.toStringAsFixed(0)}°C',
                            style: AppTypography.displayMobile.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            weather.condition,
                            style: AppTypography.labelMd.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Wrap(
                        spacing: 8,
                        runSpacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_upward, size: 12, color: Colors.deepOrange.shade700),
                              const SizedBox(width: 2),
                              Text(
                                'Máx: ${weather.tempMax.toStringAsFixed(1)}°C',
                                style: AppTypography.labelSm.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_downward, size: 12, color: Colors.blue.shade700),
                              const SizedBox(width: 2),
                              Text(
                                'Mín: ${weather.tempMin.toStringAsFixed(1)}°C',
                                style: AppTypography.labelSm.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // 4-Variable Agrometeorological Grid (Responsive)
          Row(
            children: [
              Expanded(
                child: _WeatherMetricItem(
                  icon: Icons.water_drop,
                  iconColor: const Color(0xFF1976D2),
                  label: 'Prob. Lluvia',
                  value: '${weather.rainProbability}%',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _WeatherMetricItem(
                  icon: Icons.opacity,
                  iconColor: const Color(0xFF00897B),
                  label: 'Humedad Rel.',
                  value: '${weather.humidityPercent}%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _WeatherMetricItem(
                  icon: Icons.air,
                  iconColor: const Color(0xFF546E7A),
                  label: 'Viento',
                  value: '${weather.windSpeedKmH.toStringAsFixed(1)} km/h',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _WeatherMetricItem(
                  icon: Icons.ac_unit,
                  iconColor: hasFrost ? const Color(0xFF0288D1) : const Color(0xFF78909C),
                  label: 'Riesgo Helada',
                  value: hasFrost ? weather.frostAlertLevel : 'Sin Riesgo',
                  isWarning: hasFrost,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Agronomic Recommendation Card
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.eco,
                    size: 16,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recomendación Agronómica:',
                        style: AppTypography.labelSm.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        weather.agronomicAdvice,
                        style: AppTypography.bodySm.copyWith(
                          fontSize: 11,
                          color: AppColors.onSurface,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateHeader(DateTime date) {
    const weekdays = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];
    const months = [
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

    final weekday = weekdays[date.weekday - 1];
    final day = date.day;
    final month = months[date.month - 1];
    return '$weekday, $day de $month';
  }
}

class _WeatherMetricItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool isWarning;

  const _WeatherMetricItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isWarning
            ? const Color(0xFFE1F5FE)
            : AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isWarning
              ? const Color(0xFF0288D1).withValues(alpha: 0.3)
              : AppColors.primary.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.labelSm.copyWith(
                    fontSize: 9,
                    color: AppColors.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  value,
                  style: AppTypography.labelMd.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: isWarning ? const Color(0xFF01579B) : AppColors.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
