import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/directorio_controller.dart';
import '../widgets/especialista_card.dart';

class DirectorioView extends ConsumerWidget {
  const DirectorioView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final especialistasAsync = ref.watch(directorioControllerProvider);

    return Column(
      children: [
        // Dummy filter bar (can be expanded later)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            border: Border(bottom: BorderSide(color: AppColors.primary.withValues(alpha: 0.1))),
          ),
          child: Row(
            children: [
              const Icon(Icons.filter_list, size: 20, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 8),
              Text('Filtros:', style: AppTypography.labelMd),
              const SizedBox(width: 12),
              ActionChip(
                label: const Text('Especialidad'),
                onPressed: () {},
                visualDensity: VisualDensity.compact,
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: const Text('Cultivo'),
                onPressed: () {},
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
        
        // List content
        Expanded(
          child: especialistasAsync.when(
            data: (especialistas) {
              if (especialistas.isEmpty) {
                return const Center(child: Text('No hay especialistas disponibles.'));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: especialistas.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return EspecialistaCard(especialista: especialistas[index]);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ),
      ],
    );
  }
}
