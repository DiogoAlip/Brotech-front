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
    final state = ref.watch(farmControllerProvider);

    String getCropName(String id) {
      final names = {
        'maiz': 'Maíz',
        'papa': 'Papa',
        'frijol': 'Frijol',
        'tomate': 'Tomate',
        'cacao': 'Cacao',
        'arroz': 'Arroz',
      };
      return names[id] ?? 'Cultivo';
    }

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
            tooltip: 'Borrar todo (Demo)',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashboardWeatherAlert(),
            const SizedBox(height: 32),
            
            ...state.parcels.map((parcel) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.eco, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Parcela de ${getCropName(parcel.crop)}',
                          style: AppTypography.headlineSm.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${parcel.hectares} Hectáreas - Plantada el ${parcel.date.day}/${parcel.date.month}',
                      style: AppTypography.bodyLg.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    Text(
                      'Seguimiento',
                      style: AppTypography.labelLg.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const DashboardTimeline(),
                    const SizedBox(height: 32),
                    
                    Text(
                      'Tareas Recomendadas',
                      style: AppTypography.labelLg.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const DashboardTaskCard(),
                  ],
                ),
              );
            }),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {
                  controller.startNewParcel();
                },
                icon: const Icon(Icons.add),
                label: Text(
                  'Añadir otra parcela',
                  style: AppTypography.labelLg.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  foregroundColor: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

