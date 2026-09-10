import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/calendar_controller.dart';

class WeatherAlertBanner extends ConsumerWidget {
  const WeatherAlertBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarControllerProvider);
    if (state.isClimateAlertDismissed) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: () => ref.read(calendarControllerProvider.notifier).showClimateAlert(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE1F5FE),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF0288D1).withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.ac_unit, size: 16, color: Color(0xFF0288D1)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Aviso activo: Heladas y cambios climáticos (Toca para ver)',
                    style: AppTypography.labelSm.copyWith(
                      color: const Color(0xFF01579B),
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF0288D1)),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF0288D1).withValues(alpha: 0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0288D1).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header with Warning Icon, Title, and Dismiss Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0288D1).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.ac_unit,
                  size: 18,
                  color: Color(0xFF0288D1),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Heladas y cambios climáticos',
                          style: AppTypography.headlineSm.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF01579B),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8F00).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Alerta Activa',
                            style: AppTypography.labelSm.copyWith(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFE65100),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Descenso térmico brusco en madrugadas (1°C - 3°C). Alta probabilidad de heladas radiativas en zonas bajas y parcelas desprotegidas.',
                      style: AppTypography.bodySm.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF0D47A1),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () => ref.read(calendarControllerProvider.notifier).dismissClimateAlert(),
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Color(0xFF546E7A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: Color(0x200288D1)),
          const SizedBox(height: 8),

          // Actionable Agronomic Measures
          Text(
            'Medidas preventivas recomendadas:',
            style: AppTypography.labelSm.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF01579B),
            ),
          ),
          const SizedBox(height: 6),
          const Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _ActionChip(
                icon: Icons.water_drop,
                label: 'Riego por aspersión nocturno',
              ),
              _ActionChip(
                icon: Icons.shield,
                label: 'Mantas térmicas en almácigos',
              ),
              _ActionChip(
                icon: Icons.thermostat,
                label: 'Monitoreo de suelo a 5 cm',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF0288D1).withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF0288D1)),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: AppTypography.labelSm.copyWith(
                fontSize: 10,
                color: const Color(0xFF0D47A1),
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
