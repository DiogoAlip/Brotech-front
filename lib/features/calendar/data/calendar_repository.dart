import '../domain/models/daily_weather.dart';

class CalendarRepository {
  final Map<String, DailyWeather> _weatherCache = {};

  CalendarRepository() {
    _initKeyDates();
  }

  String _dateKey(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  DailyWeather getWeatherForDate(DateTime date) {
    final key = _dateKey(date);
    if (_weatherCache.containsKey(key)) {
      return _weatherCache[key]!;
    }
    final weather = _generateWeatherForDate(date);
    _weatherCache[key] = weather;
    return weather;
  }

  bool hasFrostRiskOnDate(DateTime date) {
    return getWeatherForDate(date).hasFrostRisk;
  }

  List<DailyWeather> getUpcomingForecast(DateTime fromDate, {int days = 7}) {
    final list = <DailyWeather>[];
    for (int i = 0; i < days; i++) {
      final d = fromDate.add(Duration(days: i));
      list.add(getWeatherForDate(d));
    }
    return list;
  }

  void _initKeyDates() {
    // Key date for testing and demonstration: May 14, 2025 (Active Frost Risk)
    _weatherCache['2025-05-14'] = DailyWeather(
      date: DateTime(2025, 5, 14),
      condition: 'Riesgo de Helada Radiativa',
      conditionCategory: 'helada',
      currentTemp: 14.5,
      tempMax: 22.0,
      tempMin: 1.5,
      rainProbability: 10,
      humidityPercent: 78,
      windSpeedKmH: 8.5,
      hasFrostRisk: true,
      frostAlertLevel: 'Moderado',
      agronomicAdvice:
          'Descenso térmico brusco en la madrugada (1.5°C). Activar riego por aspersión preventivo y colocar mantas térmicas en almácigos sensibles.',
    );

    // May 15, 2025 (Soleado favorable)
    _weatherCache['2025-05-15'] = DailyWeather(
      date: DateTime(2025, 5, 15),
      condition: 'Soleado y Despejado',
      conditionCategory: 'soleado',
      currentTemp: 21.0,
      tempMax: 24.5,
      tempMin: 8.0,
      rainProbability: 5,
      humidityPercent: 55,
      windSpeedKmH: 12.0,
      hasFrostRisk: false,
      frostAlertLevel: 'Ninguna',
      agronomicAdvice:
          'Condiciones lumínicas y térmicas excelentes. Día propicio para labores de poda liviana y fertilización foliar.',
    );

    // May 16, 2025 (Lluvia benéfica)
    _weatherCache['2025-05-16'] = DailyWeather(
      date: DateTime(2025, 5, 16),
      condition: 'Lluvias Aisladas',
      conditionCategory: 'lluvia',
      currentTemp: 17.5,
      tempMax: 19.0,
      tempMin: 11.0,
      rainProbability: 75,
      humidityPercent: 88,
      windSpeedKmH: 16.0,
      hasFrostRisk: false,
      frostAlertLevel: 'Ninguna',
      agronomicAdvice:
          'Precipitaciones previstas. Suspender riego mecanizado y verificar drenajes en bancales bajos.',
    );

    // Also seed Today with a comprehensive agricultural weather forecast
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final todayKey = _dateKey(today);
    if (!_weatherCache.containsKey(todayKey)) {
      _weatherCache[todayKey] = DailyWeather(
        date: today,
        condition: 'Alerta de Helada y Cambio Climático',
        conditionCategory: 'helada',
        currentTemp: 15.0,
        tempMax: 21.5,
        tempMin: 2.0,
        rainProbability: 15,
        humidityPercent: 74,
        windSpeedKmH: 10.5,
        hasFrostRisk: true,
        frostAlertLevel: 'Crítico',
        agronomicAdvice:
            'Alerta por helada en la madrugada. Se recomienda cubrir cultivos tiernos y regar al anochecer para conservar inercia térmica en el suelo.',
      );
    }
  }

  DailyWeather _generateWeatherForDate(DateTime date) {
    // Seed deterministically based on date attributes
    final seed = (date.year * 365 + date.month * 31 + date.day) % 100;

    // Simulate frost risk for days ending in 4 or 8 or during winter cycles
    final isFrost = (date.day % 5 == 0) || (date.month >= 5 && date.month <= 8 && date.day % 3 == 0);

    if (isFrost) {
      final minTemp = 1.0 + (seed % 30) / 10.0; // 1.0 to 3.9 °C
      final maxTemp = 18.0 + (seed % 50) / 10.0; // 18.0 to 22.9 °C
      return DailyWeather(
        date: date,
        condition: 'Riesgo de Helada Radiativa',
        conditionCategory: 'helada',
        currentTemp: (minTemp + maxTemp) / 2,
        tempMax: maxTemp,
        tempMin: minTemp,
        rainProbability: 10 + (seed % 20),
        humidityPercent: 70 + (seed % 25),
        windSpeedKmH: 6.0 + (seed % 10),
        hasFrostRisk: true,
        frostAlertLevel: minTemp <= 2.0 ? 'Crítico' : 'Moderado',
        agronomicAdvice:
            'Riesgo agrometeorológico de heladas: Descenso térmico a ${minTemp.toStringAsFixed(1)}°C. Utilizar coberturas plásticas o mantas térmicas en almácigos.',
      );
    }

    // Rain days
    if (seed % 4 == 0) {
      final minTemp = 10.0 + (seed % 40) / 10.0;
      final maxTemp = 18.0 + (seed % 40) / 10.0;
      return DailyWeather(
        date: date,
        condition: 'Lluvia y Nubosidad Alta',
        conditionCategory: 'lluvia',
        currentTemp: (minTemp + maxTemp) / 2,
        tempMax: maxTemp,
        tempMin: minTemp,
        rainProbability: 60 + (seed % 35),
        humidityPercent: 80 + (seed % 18),
        windSpeedKmH: 14.0 + (seed % 12),
        hasFrostRisk: false,
        frostAlertLevel: 'Ninguna',
        agronomicAdvice:
            'Precipitaciones activas: Evitar aplicaciones de agroquímicos foliares por riesgo de lavado. Mantener canales de drenaje despejados.',
      );
    }

    // Cloudy days
    if (seed % 3 == 0) {
      final minTemp = 9.0 + (seed % 30) / 10.0;
      final maxTemp = 21.0 + (seed % 40) / 10.0;
      return DailyWeather(
        date: date,
        condition: 'Parcialmente Nublado',
        conditionCategory: 'nublado',
        currentTemp: (minTemp + maxTemp) / 2,
        tempMax: maxTemp,
        tempMin: minTemp,
        rainProbability: 25 + (seed % 25),
        humidityPercent: 65 + (seed % 20),
        windSpeedKmH: 10.0 + (seed % 10),
        hasFrostRisk: false,
        frostAlertLevel: 'Ninguna',
        agronomicAdvice:
            'Nubosidad moderada y evapotranspiración baja. Adecuado para trasplantes y manejo de suelos.',
      );
    }

    // Sunny days
    final minTemp = 8.0 + (seed % 40) / 10.0;
    final maxTemp = 22.0 + (seed % 70) / 10.0;
    return DailyWeather(
      date: date,
      condition: 'Soleado y Óptimo',
      conditionCategory: 'soleado',
      currentTemp: (minTemp + maxTemp) / 2,
      tempMax: maxTemp,
      tempMin: minTemp,
      rainProbability: 5 + (seed % 15),
      humidityPercent: 45 + (seed % 25),
      windSpeedKmH: 8.0 + (seed % 12),
      hasFrostRisk: false,
      frostAlertLevel: 'Ninguna',
      agronomicAdvice:
          'Clima óptimo y radiación adecuada. Buen momento para labores agrícolas y riego programado.',
    );
  }
}
