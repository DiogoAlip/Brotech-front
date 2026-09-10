import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/farm_controller.dart';
import '../widgets/parcel_parameters_card.dart';
import '../widgets/parcel_cartography_card.dart';
import '../widgets/registered_parcels_list.dart';

class FarmScreen extends ConsumerWidget {
  const FarmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(farmControllerProvider);
    final controller = ref.read(farmControllerProvider.notifier);

    // Show feedback if message exists
    ref.listen<FarmState>(farmControllerProvider, (prev, next) {
      if (next.message != null && next.message != prev?.message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message!),
            backgroundColor: AppColors.primaryContainer,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Catastral Badge Row
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 6,
              children: [
                Text(
                  'REGISTRO CATASTRAL • LOTE SEC-2025',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    "Val d'Orcia Terroir",
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Page Title
            Text(
              'Registro de Finca y Parcelas',
              style: AppTypography.headlineLg.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Configure la asignación de tierras, la metodología de siembra y los cultivares de semillas certificados para el seguimiento preciso del campo y el rendimiento de la cosecha.',
              style: AppTypography.bodySm.copyWith(
                color: AppColors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // Parameters Form Card
            const ParcelParametersCard(),
            const SizedBox(height: 20),

            // Visual Cartography Card
            const ParcelCartographyCard(),
            const SizedBox(height: 20),

            // Operational Action Buttons
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: state.isSaving ? null : () => controller.registerParcel(),
                icon: state.isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.save, size: 20),
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    state.isSaving ? 'Registrando...' : 'Registrar Configuración de Parcela',
                    style: AppTypography.labelLg.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Exportando capa cartográfica GIS (.SHP)...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.share_location, size: 18),
                label: Text(
                  'Exportar Archivo GIS (.SHP)',
                  style: AppTypography.labelLg.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Registered Parcels Section
            const RegisteredParcelsList(),
            const SizedBox(height: 32),

            // Compliance Note
            Center(
              child: Column(
                children: [
                  Text(
                    'RED DE SUELOS Y SEMILLAS CERTIFICADAS BROTEC',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Conforme a la Evaluación Botánica ISO-24538 y la Directiva Europea 2002/55/CE',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySm.copyWith(
                      fontSize: 10.5,
                      color: AppColors.onSurfaceVariant,
                    ),
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
