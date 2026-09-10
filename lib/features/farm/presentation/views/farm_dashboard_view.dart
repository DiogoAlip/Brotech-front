import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/farm_controller.dart';
import '../widgets/dashboard/dashboard_weather_alert.dart';
import '../widgets/dashboard/dashboard_timeline.dart';
import '../widgets/dashboard/dashboard_task_card.dart';

class FarmDashboardView extends ConsumerWidget {
  const FarmDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(farmControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mi Finca',
          style: AppTypography.headlineSm.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: () {
              // Delete crop and reset flow for demo
              controller.resetFlow();
            },
            tooltip: 'Borrar cultivo (Demo)',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashboardWeatherAlert(),
            const SizedBox(height: 24),
            
            Text(
              'Seguimiento',
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            const DashboardTimeline(),
            const SizedBox(height: 32),
            
            Text(
              'Tareas Recomendadas',
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            const DashboardTaskCard(),
          ],
        ),
      ),
    );
  }
}
