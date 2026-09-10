import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/agronomist_profile.dart';
import '../controllers/profile_controller.dart';

class ProfileBioCard extends ConsumerWidget {
  final AgronomistProfile profile;
  final ValueChanged<String>? onStatusChanged;

  const ProfileBioCard({
    super.key,
    required this.profile,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInactive = profile.status.toLowerCase() == 'inactivo';
    final statusColor = isInactive ? const Color(0xFF78716C) : AppColors.secondary;
    final statusBgColor = isInactive
        ? const Color(0xFF78716C).withValues(alpha: 0.1)
        : AppColors.secondary.withValues(alpha: 0.1);
    final statusBorderColor = isInactive
        ? const Color(0xFF78716C).withValues(alpha: 0.25)
        : AppColors.secondary.withValues(alpha: 0.25);

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
                              Expanded(
                                child: Text(
                                  profile.name,
                                  style: AppTypography.headlineSm.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                                decoration: BoxDecoration(
                                  color: statusBgColor,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: statusBorderColor),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    key: const ValueKey('profile_status_dropdown'),
                                    value: isInactive ? 'Inactivo' : 'Activo',
                                    isDense: true,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 15,
                                        color: statusColor,
                                      ),
                                    ),
                                    dropdownColor: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(8),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Activo',
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: const BoxDecoration(
                                                color: AppColors.secondary,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Activo',
                                              style: AppTypography.labelSm.copyWith(
                                                color: AppColors.secondary,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Inactivo',
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF78716C),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Inactivo',
                                              style: AppTypography.labelSm.copyWith(
                                                color: const Color(0xFF78716C),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    onChanged: (val) {
                                      if (val != null) {
                                        if (onStatusChanged != null) {
                                          onStatusChanged!(val);
                                        } else {
                                          ref.read(profileControllerProvider.notifier).updateStatus(val);
                                        }
                                      }
                                    },
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
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.pin_drop, size: 14, color: AppColors.primary),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      profile.farmName,
                                      style: AppTypography.bodySm.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const Text('•', style: TextStyle(color: AppColors.onSurfaceVariant)),
                              Text(profile.zone, style: AppTypography.bodySm.copyWith(fontSize: 11)),
                              const Text('•', style: TextStyle(color: AppColors.onSurfaceVariant)),
                              Text('${profile.hectares.toStringAsFixed(0)} Ha', style: AppTypography.bodySm.copyWith(fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
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
