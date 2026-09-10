import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/calendar_controller.dart';
import '../widgets/calendar_control_card.dart';
import '../widgets/upcoming_weather_list.dart';
import '../widgets/weather_alert_banner.dart';
import '../widgets/weather_detail_card.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Climate Notification: Heladas y cambios climáticos
            const WeatherAlertBanner(),

            // 2. Interactive Calendar Grid (Month / Week View with Weather Indicators)
            const CalendarControlCard(),
            const SizedBox(height: 16),

            // 3. Selected Date Agrometeorological Detail Card
            WeatherDetailCard(weather: state.selectedWeather),
            const SizedBox(height: 18),

            // 4. Other Dates Agrometeorological Forecast (Upcoming & Exploratory Dates)
            const UpcomingWeatherList(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
