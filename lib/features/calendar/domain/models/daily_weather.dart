import 'package:flutter/material.dart';

/// Represents daily agrometeorological weather conditions for agricultural planning.
class DailyWeather {
  final DateTime date;
  final String condition;
  final double currentTemp;
  final double tempMax;
  final double tempMin;
  final int rainProbability;
  final int humidityPercent;
  final double windSpeedKmH;
  final bool hasFrostRisk;
  final String frostAlertLevel; // 'Ninguna', 'Bajo', 'Moderado', 'Crítico'
  final String agronomicAdvice;
  final String conditionCategory; // 'soleado', 'lluvia', 'helada', 'nublado'

  const DailyWeather({
    required this.date,
    required this.condition,
    required this.currentTemp,
    required this.tempMax,
    required this.tempMin,
    required this.rainProbability,
    required this.humidityPercent,
    required this.windSpeedKmH,
    required this.hasFrostRisk,
    this.frostAlertLevel = 'Ninguna',
    required this.agronomicAdvice,
    this.conditionCategory = 'soleado',
  });

  IconData get weatherIcon {
    if (hasFrostRisk) return Icons.ac_unit;
    switch (conditionCategory) {
      case 'helada':
        return Icons.ac_unit;
      case 'lluvia':
        return Icons.water_drop_rounded;
      case 'nublado':
        return Icons.cloud_rounded;
      case 'tormenta':
        return Icons.thunderstorm_rounded;
      case 'soleado':
      default:
        return Icons.wb_sunny_rounded;
    }
  }

  Color get indicatorColor {
    if (hasFrostRisk) return const Color(0xFF0288D1); // Frost Cyan / Blue
    switch (conditionCategory) {
      case 'helada':
        return const Color(0xFF0288D1);
      case 'lluvia':
        return const Color(0xFF1976D2);
      case 'nublado':
        return const Color(0xFF78909C);
      case 'tormenta':
        return const Color(0xFF5E35B1);
      case 'soleado':
      default:
        return const Color(0xFFF57F17); // Golden Sun
    }
  }

  DailyWeather copyWith({
    DateTime? date,
    String? condition,
    double? currentTemp,
    double? tempMax,
    double? tempMin,
    int? rainProbability,
    int? humidityPercent,
    double? windSpeedKmH,
    bool? hasFrostRisk,
    String? frostAlertLevel,
    String? agronomicAdvice,
    String? conditionCategory,
  }) {
    return DailyWeather(
      date: date ?? this.date,
      condition: condition ?? this.condition,
      currentTemp: currentTemp ?? this.currentTemp,
      tempMax: tempMax ?? this.tempMax,
      tempMin: tempMin ?? this.tempMin,
      rainProbability: rainProbability ?? this.rainProbability,
      humidityPercent: humidityPercent ?? this.humidityPercent,
      windSpeedKmH: windSpeedKmH ?? this.windSpeedKmH,
      hasFrostRisk: hasFrostRisk ?? this.hasFrostRisk,
      frostAlertLevel: frostAlertLevel ?? this.frostAlertLevel,
      agronomicAdvice: agronomicAdvice ?? this.agronomicAdvice,
      conditionCategory: conditionCategory ?? this.conditionCategory,
    );
  }
}
