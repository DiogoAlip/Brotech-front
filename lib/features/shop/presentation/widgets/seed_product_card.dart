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
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botanical Photograph Container (4:3 aspect ratio)
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
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
              Positioned(
                top: 8,
                left: 8,
                child: Row(
                  children: [
                    if (product.discountLabel != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.tertiaryFixedDim,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.discountLabel!,
                          style: AppTypography.labelSm.copyWith(
                            color: AppColors.tertiary,
                            fontWeight: FontWeight.w800,
                            fontSize: 9.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                      ),
                      child: Text(
                        product.lotCode,
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 9.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Details & Specifications Ledger
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: AppTypography.headlineSm.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            product.scientificName,
                            style: AppTypography.bodySm.copyWith(
                              fontStyle: FontStyle.italic,
                              fontSize: 11,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: AppTypography.numericMetric.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                        if (product.originalPrice != null)
                          Text(
                            '\$${product.originalPrice!.toStringAsFixed(2)}',
                            style: AppTypography.bodySm.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.outline,
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Key metrics ledger
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified, size: 14, color: AppColors.secondary),
                          const SizedBox(width: 4),
                          Text(
                            'Germ: ${product.germinationRate}% ISTA',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        product.treatment,
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Fast Add button
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      padding: EdgeInsets.zero,
                    ),
                    icon: const Icon(Icons.shopping_cart, size: 16),
                    label: Text(
                      'Añadir al Carrito',
                      style: AppTypography.labelMd.copyWith(
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
