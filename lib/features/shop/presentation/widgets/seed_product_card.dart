import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/seed_product.dart';

class SeedProductCard extends StatelessWidget {
  final SeedProduct product;
  final VoidCallback onAddToCart;

  const SeedProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and badges
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: AppColors.surfaceContainerHigh,
                  child: Image.asset(
                    'assets/images/farm_landscape.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => const Center(
                      child: Icon(Icons.eco, color: AppColors.secondary, size: 40),
                    ),
                  ),
                ),
              ),
              if (product.discountLabel != null)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      product.discountLabel!,
                      style: AppTypography.labelLg.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: AppTypography.headlineSm.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'S/ ${product.price.toStringAsFixed(2)}',
                          style: AppTypography.headlineSm.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                        if (product.originalPrice != null)
                          Text(
                            'S/ ${product.originalPrice!.toStringAsFixed(2)}',
                            style: AppTypography.bodyLg.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.outline,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Provider and Certifications
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: product.isCertifiedProvider
                        ? AppColors.secondaryContainer.withValues(alpha: 0.3)
                        : AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: product.isCertifiedProvider
                          ? AppColors.secondary
                          : AppColors.outlineVariant,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        product.isCertifiedProvider ? Icons.verified : Icons.store,
                        color: product.isCertifiedProvider ? AppColors.secondary : AppColors.onSurfaceVariant,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.providerName,
                              style: AppTypography.labelLg.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                            ),
                            if (product.certificationDetails != null)
                              Text(
                                product.certificationDetails!,
                                style: AppTypography.bodySm.copyWith(
                                  color: product.isCertifiedProvider ? AppColors.secondary : AppColors.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Quality Label
                Row(
                  children: [
                    const Icon(Icons.thumb_up_alt_outlined, size: 20, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        product.qualityLabel,
                        style: AppTypography.labelLg.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Add to Cart Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    label: Text(
                      'Agregar al Carrito',
                      style: AppTypography.labelLg.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
