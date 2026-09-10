import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../controllers/farm_controller.dart';

class WizardCropStep extends ConsumerWidget {
  final VoidCallback onNext;

  const WizardCropStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(farmControllerProvider);
    final controller = ref.read(farmControllerProvider.notifier);

    final crops = [
      {'id': 'cacao', 'name': 'Cacao', 'icon': Icons.forest},
      {'id': 'arroz', 'name': 'Arroz', 'icon': Icons.water},
      {'id': 'maiz', 'name': 'Maíz', 'icon': Icons.grass},
      {'id': 'papa', 'name': 'Papa', 'icon': Icons.eco},
      {'id': 'frijol', 'name': 'Frijol', 'icon': Icons.spa},
      {'id': 'tomate', 'name': 'Tomate', 'icon': Icons.local_florist},
    ];

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
                    '¿Qué cultivo vamos a sembrar?',
                    style: AppTypography.headlineLg.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Selecciona el cultivo principal de tu parcela para calcular la siembra ideal.',
                    style: AppTypography.bodyLg.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: crops.length,
                    itemBuilder: (context, index) {
                      final crop = crops[index];
                      final isSelected = state.selectedCrop == crop['id'];

                      return InkWell(
                        onTap: () {
                          controller.selectCrop(crop['id'] as String);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainer,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                crop['icon'] as IconData,
                                size: 48,
                                color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                crop['name'] as String,
                                style: AppTypography.labelLg.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? AppColors.primary : AppColors.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: state.selectedCrop != null ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.surfaceContainerHigh,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Siguiente',
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
