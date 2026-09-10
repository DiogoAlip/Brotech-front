import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_bio_card.dart';
import '../widgets/profile_stats_grid.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Bio Card
            ProfileBioCard(profile: profile),
            const SizedBox(height: 16),

            // Bento Quick Stats Grid
            ProfileStatsGrid(profile: profile),
            const SizedBox(height: 20),

            // Operations & Management Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.agriculture, color: AppColors.secondary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Operaciones Agronómicas',
                      style: AppTypography.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Ver Todo',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Operation Item 1: Recent Seed Order
            _OperationTile(
              icon: Icons.local_shipping,
              title: 'Pedido de Semillas #ORD-9921',
              subtitle: '3 Lotes Certificados • Despacho Finca El Roble',
              status: 'En Tránsito',
              statusColor: AppColors.secondary,
              onTap: () {},
            ),
            const SizedBox(height: 8),

            // Operation Item 2: Sensor Calibration
            _OperationTile(
              icon: Icons.sensors,
              title: 'Calibración de Sondas IoT',
              subtitle: '18 Sondas activas • Humedad 68% • pH 6.4',
              status: 'Calibrado',
              statusColor: AppColors.primaryContainer,
              onTap: () {},
            ),
            const SizedBox(height: 8),

            // Operation Item 3: ISTA Seed Certificate
            _OperationTile(
              icon: Icons.workspace_premium,
              title: 'Certificación ISTA Lote #SM-2025',
              subtitle: 'Germinación 98.4% verificada en laboratorio',
              status: 'Aprobado',
              statusColor: AppColors.tertiaryFixedDim,
              onTap: () {},
            ),
            const SizedBox(height: 24),

            // Account & Preferences Section
            Text(
              'Configuración y Preferencias',
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  _PreferenceRow(
                    icon: Icons.notifications_active,
                    title: 'Alertas Agro-Climáticas',
                    trailing: Switch.adaptive(
                      value: true,
                      activeColor: AppColors.secondary,
                      onChanged: (val) {},
                    ),
                  ),
                  const Divider(height: 1, color: Color(0x1A114036)),
                  _PreferenceRow(
                    icon: Icons.cloud_sync,
                    title: 'Sincronización Estación Meteorológica',
                    trailing: const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: Color(0x1A114036)),
                  _PreferenceRow(
                    icon: Icons.security,
                    title: 'Credenciales y Certificados Botánicos',
                    trailing: const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: Color(0x1A114036)),
                  _PreferenceRow(
                    icon: Icons.logout,
                    title: 'Cerrar Sesión',
                    titleColor: AppColors.error,
                    iconColor: AppColors.error,
                    trailing: const SizedBox.shrink(),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _OperationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final VoidCallback onTap;

  const _OperationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                status,
                style: AppTypography.labelSm.copyWith(
                  color: statusColor == AppColors.tertiaryFixedDim ? AppColors.tertiary : statusColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final Color? titleColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const _PreferenceRow({
    required this.icon,
    required this.title,
    required this.trailing,
    this.titleColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: iconColor ?? AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTypography.bodyMd.copyWith(
                    fontWeight: FontWeight.w600,
                    color: titleColor ?? AppColors.onSurface,
                  ),
                ),
              ],
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
