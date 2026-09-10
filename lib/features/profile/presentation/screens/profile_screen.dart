import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/theme_provider.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_bio_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);
    final isDark = ref.watch(isDarkModeProvider);

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

            // Operations & Management Section (Shop processes & Certifications)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Operaciones y Certificaciones',
                    style: AppTypography.headlineSm.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
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

            // Shop Process 1: Recent Seed Order
            _OperationTile(
              icon: Icons.local_shipping_outlined,
              title: 'Pedido de Semillas #ORD-9921',
              subtitle: '3 Lotes Certificados • Despacho Finca El Roble',
              status: 'En Tránsito',
              statusColor: AppColors.secondary,
              onTap: () {},
            ),
            const SizedBox(height: 8),

            // Shop Process 2: Purchase Order
            _OperationTile(
              icon: Icons.receipt_long_outlined,
              title: 'Orden de Compra #ORD-9924',
              subtitle: 'Tomate San Marzano • Pago Confirmado en Tienda',
              status: 'En Preparación',
              statusColor: AppColors.primaryContainer,
              onTap: () {},
            ),
            const SizedBox(height: 8),

            // Certification 1: ISTA Seed Certificate
            _OperationTile(
              icon: Icons.workspace_premium_outlined,
              title: 'Certificación ISTA Lote #SM-2025',
              subtitle: 'Germinación 98.4% verificada en laboratorio',
              status: 'Aprobado',
              statusColor: AppColors.secondary,
              onTap: () {},
            ),
            const SizedBox(height: 8),

            // Certification 2: Phytosanitary Certificate
            _OperationTile(
              icon: Icons.verified_user_outlined,
              title: 'Certificado Fitosanitario SENASA',
              subtitle: 'Lote libre de patógenos y plagas cuarentenarias',
              status: 'Vigente',
              statusColor: AppColors.secondaryAccent,
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
                    icon: Icons.notifications_active_outlined,
                    title: 'Alertas Agro-Climáticas',
                    trailing: Switch.adaptive(
                      value: true,
                      activeTrackColor: AppColors.secondary,
                      onChanged: (val) {},
                    ),
                  ),
                  const Divider(height: 1, color: Color(0x1A114036)),
                  _PreferenceRow(
                    icon: isDark ? Icons.dark_mode : Icons.dark_mode_outlined,
                    title: 'Modo Oscuro',
                    trailing: Switch.adaptive(
                      value: isDark,
                      activeTrackColor: AppColors.secondary,
                      onChanged: (val) {
                        ref.read(isDarkModeProvider.notifier).state = val;
                      },
                    ),
                  ),
                  const Divider(height: 1, color: Color(0x1A114036)),
                  _PreferenceRow(
                    icon: Icons.security_outlined,
                    title: 'Credenciales y Certificados Botánicos',
                    trailing: const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: Color(0x1A114036)),
                  _PreferenceRow(
                    icon: Icons.logout_outlined,
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
            const SizedBox(width: 8),
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
            Expanded(
              child: Row(
                children: [
                  Icon(icon, size: 20, color: iconColor ?? AppColors.primary),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      title,
                      style: AppTypography.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: titleColor ?? AppColors.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            trailing,
          ],
        ),
      ),
    );
  }
}
