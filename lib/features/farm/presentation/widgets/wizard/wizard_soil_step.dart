import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../controllers/farm_controller.dart';

class WizardSoilStep extends ConsumerWidget {
  final VoidCallback onNext;

  const WizardSoilStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(farmControllerProvider);
    final controller = ref.read(farmControllerProvider.notifier);

    final soils = [
      {'id': 'arenosa', 'name': 'Arenosa', 'desc': 'Se escurre el agua rápido'},
      {'id': 'arcillosa', 'name': 'Arcillosa', 'desc': 'Retiene mucha agua, hace charcos'},
      {'id': 'franca', 'name': 'Franca', 'desc': 'Tierra oscura, ideal para sembrar'},
    ];

    Widget soilButton(Map<String, String> soil) {
      final isSelected = state.selectedSoilType == soil['id'];
      
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: InkWell(
          onTap: () => controller.selectSoilType(soil['id']),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  soil['name']!,
                  style: AppTypography.labelLg.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? AppColors.primary : AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  soil['desc']!,
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Conoces el tipo de tierra?',
                    style: AppTypography.headlineLg.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Es opcional, pero ayuda a recomendarte el mejor riego.',
                    style: AppTypography.bodyLg.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  ...soils.map((soil) => soilButton(soil)),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                controller.selectSoilType(null); // Skip
                onNext();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'No estoy seguro (Saltar)',
                style: AppTypography.labelLg.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: state.selectedSoilType != null ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.surfaceContainerHigh,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Finalizar',
                style: AppTypography.labelLg.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
