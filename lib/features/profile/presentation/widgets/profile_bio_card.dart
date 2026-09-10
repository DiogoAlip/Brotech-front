import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/agronomist_profile.dart';

class ProfileBioCard extends StatelessWidget {
  final AgronomistProfile profile;

  const ProfileBioCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Top Botanical Emerald Stripe
          Container(height: 4, color: AppColors.secondary),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with verified badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryContainer, width: 2),
                            color: AppColors.surfaceContainer,
                          ),
                          child: const Icon(Icons.person, size: 40, color: AppColors.primary),
                        ),
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: AppColors.tertiaryFixedDim,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                            child: const Icon(Icons.verified, size: 13, color: AppColors.tertiary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),

                    // User Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profile.name,
                                style: AppTypography.headlineSm.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2)),
                                ),
                                child: Text(
                                  profile.status,
                                  style: AppTypography.labelSm.copyWith(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 9.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            profile.title,
                            style: AppTypography.labelMd.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.pin_drop, size: 14, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text(
                                profile.farmName,
                                style: AppTypography.bodySm.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text('•', style: TextStyle(color: AppColors.onSurfaceVariant)),
                              const SizedBox(width: 6),
                              Text(profile.zone, style: AppTypography.bodySm.copyWith(fontSize: 11)),
                              const SizedBox(width: 6),
                              const Text('•', style: TextStyle(color: AppColors.onSurfaceVariant)),
                              const SizedBox(width: 6),
                              Text('${profile.hectares.toStringAsFixed(0)} Ha', style: AppTypography.bodySm.copyWith(fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0x1A114036)),
                const SizedBox(height: 12),

                // Trust Badges / Verification Ribbons
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _Ribbon(
                      icon: Icons.eco,
                      label: 'Productor Orgánico Certificado',
                      bgColor: const Color(0x3378F9D1),
                      iconColor: AppColors.secondary,
                    ),
                    _Ribbon(
                      icon: Icons.workspace_premium,
                      label: 'Garantía Botánica ISTA',
                      bgColor: const Color(0x33FDBB42),
                      iconColor: AppColors.tertiaryFixedDim,
                    ),
                    _Ribbon(
                      icon: Icons.biotech,
                      label: profile.labId,
                      bgColor: AppColors.surfaceContainer,
                      iconColor: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Ribbon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;

  const _Ribbon({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.labelSm.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}
