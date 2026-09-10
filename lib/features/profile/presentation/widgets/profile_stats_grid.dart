import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/agronomist_profile.dart';

class ProfileStatsGrid extends StatelessWidget {
  final AgronomistProfile profile;

  const ProfileStatsGrid({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.6,
      children: [
        // Stat 1: Parcelas Activas
        _StatCard(
          title: 'Parcelas Activas',
          value: '${profile.activePlots}',
          subtitle: 'todas bajo riego',
          icon: Icons.crop_landscape,
          isPrimary: true,
        ),
        // Stat 2: Lotes Registrados
        _StatCard(
          title: 'Lotes Registrados',
          value: '${profile.registeredLots}',
          subtitle: 'lotes certificados',
          icon: Icons.grain,
          isPrimary: true,
        ),
        // Stat 3: Germinación Media
        _StatCard(
          title: 'Germinación Media',
          value: '${profile.averageGermination}%',
          subtitle: '+2.1% YoY',
          icon: Icons.bar_chart,
          isPrimary: false,
        ),
        // Stat 4: Estado de Sondas IoT
        _StatCard(
          title: 'Estado de Sondas IoT',
          value: profile.probesOnline,
          subtitle: 'telemetría en línea',
          icon: Icons.sensors,
          isPrimary: false,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final bool isPrimary;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primaryContainer : AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isPrimary ? AppColors.primaryContainer : AppColors.primary.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.labelSm.copyWith(
                  color: isPrimary ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
                  fontSize: 10,
                ),
              ),
              Icon(
                icon,
                size: 18,
                color: isPrimary ? AppColors.secondaryContainer : AppColors.secondary,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTypography.numericMetric.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: isPrimary ? Colors.white : AppColors.primary,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.labelSm.copyWith(
                    color: isPrimary ? const Color(0xFF59DCB5) : AppColors.secondary,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
