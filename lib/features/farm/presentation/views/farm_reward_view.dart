import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/farm_controller.dart';
import 'package:intl/intl.dart';

class FarmRewardView extends ConsumerWidget {
  const FarmRewardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(farmControllerProvider.notifier);
    final state = ref.read(farmControllerProvider);
    final cropId = state.selectedCrop ?? 'maiz';
    final hectares = state.selectedHectares ?? 1.0;

    // Mock data based on crop
    String plantaCm = '20';
    String surcoCm = '80';
    String cropName = 'Maíz';
    double sqMetersPerPlant = 0.2 * 0.8;

    if (cropId == 'papa') {
      plantaCm = '30';
      surcoCm = '90';
      cropName = 'Papa';
      sqMetersPerPlant = 0.3 * 0.9;
    } else if (cropId == 'frijol') {
      plantaCm = '15';
      surcoCm = '60';
      cropName = 'Frijol';
      sqMetersPerPlant = 0.15 * 0.6;
    } else if (cropId == 'tomate') {
      plantaCm = '40';
      surcoCm = '120';
      cropName = 'Tomate';
      sqMetersPerPlant = 0.4 * 1.2;
    } else if (cropId == 'cacao') {
      plantaCm = '300';
      surcoCm = '300';
      cropName = 'Cacao';
      sqMetersPerPlant = 3.0 * 3.0;
    } else if (cropId == 'arroz') {
      plantaCm = '20';
      surcoCm = '20';
      cropName = 'Arroz';
      sqMetersPerPlant = 0.2 * 0.2;
    }

    // 1 Hectare = 10,000 m^2
    final totalSqMeters = hectares * 10000;
    final estimatedPlants = (totalSqMeters / sqMetersPerPlant).round();
    final formatter = NumberFormat('#,###', 'es_PE');

    return Scaffold(
      backgroundColor: AppColors.primaryContainer,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 80,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '¡Excelente elección!',
                      style: AppTypography.headlineLg.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Para que tu $cropName rinda al máximo en tus $hectares hectáreas, esta es la distancia ideal que debes dejar:',
                      style: AppTypography.labelLg.copyWith(
                        color: AppColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    
                    // Density Graphic
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _DensityMetric(
                                icon: Icons.grass,
                                value: '$plantaCm cm',
                                label: 'Entre plantas',
                              ),
                              Container(
                                width: 2,
                                height: 60,
                                color: AppColors.surfaceContainerHigh,
                              ),
                              _DensityMetric(
                                icon: Icons.format_align_justify,
                                value: '$surcoCm cm',
                                label: 'Entre surcos',
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Divider(),
                          ),
                          Text(
                            'Aproximadamente necesitarás:',
                            style: AppTypography.labelMd.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${formatter.format(estimatedPlants)} plantas',
                            style: AppTypography.headlineMd.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.completeRegistration();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Ir a mi panel de seguimiento',
                          style: AppTypography.labelLg.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

class _DensityMetric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _DensityMetric({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: AppColors.secondary),
        const SizedBox(height: 12),
        Text(
          value,
          style: AppTypography.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.labelMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
