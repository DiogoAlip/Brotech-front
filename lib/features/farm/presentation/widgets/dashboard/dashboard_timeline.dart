import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/farm_controller.dart';

class DashboardTimeline extends ConsumerWidget {
  const DashboardTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(farmControllerProvider);
    
    // Simulate days based on selected date
    int daysDiff = 15;
    if (state.selectedDate != null) {
      daysDiff = DateTime.now().difference(state.selectedDate!).inDays;
      if (daysDiff < 0) daysDiff = 0;
    }

    final cropName = state.selectedCrop != null 
        ? state.selectedCrop![0].toUpperCase() + state.selectedCrop!.substring(1)
        : 'Cultivo';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tu $cropName',
                style: AppTypography.labelLg.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Día $daysDiff',
                  style: AppTypography.labelMd.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Está creciendo sano.',
            style: AppTypography.headlineSm.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),
          
          // Simple visual timeline
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: (daysDiff / 120).clamp(0.0, 1.0),
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                child: Icon(Icons.yard, color: Colors.white, size: 20),
              ),
              Positioned(
                right: 0,
                child: Icon(Icons.agriculture, color: Colors.white.withValues(alpha: 0.5), size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Siembra',
                style: AppTypography.labelSm.copyWith(color: Colors.white.withValues(alpha: 0.8)),
              ),
              Text(
                'Cosecha',
                style: AppTypography.labelSm.copyWith(color: Colors.white.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
