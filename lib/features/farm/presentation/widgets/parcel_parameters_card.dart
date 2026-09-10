import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/farm_controller.dart';

class ParcelParametersCard extends ConsumerWidget {
  const ParcelParametersCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(farmControllerProvider);
    final controller = ref.read(farmControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.tune, color: AppColors.secondary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Parámetros de Parcela',
                    style: AppTypography.headlineSm.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Configuración Activa',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0x1A114036)),
          const SizedBox(height: 16),

          // Input 1: Land Area / Hectares
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Superficie Total de Tierra',
                    style: AppTypography.labelMd.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const Text(' *', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(
                'Lote Máx: 250 Ha',
                style: AppTypography.bodySm,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(Icons.square_foot, color: AppColors.onSurfaceVariant, size: 20),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: state.currentHectares.toStringAsFixed(0),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: AppTypography.numericMetric.copyWith(fontSize: 18),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      isDense: true,
                    ),
                    onChanged: (val) {
                      final parsed = double.tryParse(val);
                      if (parsed != null && parsed > 0) {
                        controller.updateHectares(parsed);
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    'Ha (Hectáreas)',
                    style: AppTypography.labelMd.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Equivalente: ',
                  style: AppTypography.bodySm,
                  children: [
                    TextSpan(
                      text: '${state.acres.toStringAsFixed(1)} Acres',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '98.2% Verificado por GIS',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Input 2: Type of Sowing
          Row(
            children: [
              Text(
                'Metodología de Siembra y Disposición',
                style: AppTypography.labelMd.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
              const Text(' *', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: state.selectedSowingMethod,
                isExpanded: true,
                icon: const Icon(Icons.expand_more, color: AppColors.onSurfaceVariant),
                items: const [
                  DropdownMenuItem(
                    value: 'direct_precision',
                    child: Text('Siembra Directa / Siembra de Precisión (Certificada)'),
                  ),
                  DropdownMenuItem(
                    value: 'transplant',
                    child: Text('Trasplante / Semillero Controlado'),
                  ),
                  DropdownMenuItem(
                    value: 'broadcasting',
                    child: Text('Al Voleo / Dispersión Aérea'),
                  ),
                  DropdownMenuItem(
                    value: 'hydroponic',
                    child: Text('Hidropónico / Sistema de Surcos Protegidos'),
                  ),
                  DropdownMenuItem(
                    value: 'notill',
                    child: Text('Siembra Directa Sin Labranza (Conservación)'),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) controller.updateSowingMethod(val);
                },
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.05)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.verified, color: AppColors.secondary, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'La siembra de precisión establece una profundidad de suelo de 2.5 cm y un intervalo entre hileras de 15 cm, óptimo para la certificación agronómica.',
                    style: AppTypography.bodySm.copyWith(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Input 3: Kind of Seeds Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Tipo de Semillas y Lote de Cultivar',
                    style: AppTypography.labelMd.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const Text(' *', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 14, color: AppColors.secondary),
                    const SizedBox(width: 2),
                    Text(
                      'Buscar',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: state.selectedSeedVariety,
                isExpanded: true,
                icon: const Icon(Icons.expand_more, color: AppColors.onSurfaceVariant),
                items: const [
                  DropdownMenuItem(
                    value: 'san_marzano',
                    child: Text('San Marzano Heirloom Tomato (Solanum lycopersicum)'),
                  ),
                  DropdownMenuItem(
                    value: 'sweet_corn',
                    child: Text('Maíz Dulce Híbrido F1 Golden Queen (Zea mays)'),
                  ),
                  DropdownMenuItem(
                    value: 'hass_avocado',
                    child: Text('Portainjerto de Aguacate Hass Enano (Persea americana)'),
                  ),
                  DropdownMenuItem(
                    value: 'winter_wheat',
                    child: Text('Trigo de Invierno Certificado Lote #778'),
                  ),
                  DropdownMenuItem(
                    value: 'soybean',
                    child: Text('Soja No-GMO Cultivar Alpha (Glycine max)'),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) controller.updateSeedVariety(val);
                },
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Cultivar Metrics Preview Banner
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.biotech, color: AppColors.secondary, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          'Métricas del Cultivar Seleccionado',
                          style: AppTypography.labelMd.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'USDA Organic',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 1, color: Color(0x1A114036)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _MetricColumn(label: 'GERMINACIÓN', value: '98.4%'),
                    _MetricColumn(label: 'pH OBJETIVO', value: '6.2 - 6.8'),
                    _MetricColumn(label: 'DENSIDAD', value: '28k/Ha'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Lot #SM-2025-ITA • Cosecha Certificada 2024 • Germoplasma Orgánico Sin Tratar',
                  style: AppTypography.bodySm.copyWith(
                    fontStyle: FontStyle.italic,
                    fontSize: 10.5,
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

class _MetricColumn extends StatelessWidget {
  final String label;
  final String value;

  const _MetricColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            fontSize: 9,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTypography.numericMetric.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
