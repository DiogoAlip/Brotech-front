import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/especialista.dart';
import 'agendar_cita_sheet.dart';

class EspecialistaCard extends StatelessWidget {
  final Especialista especialista;

  const EspecialistaCard({
    super.key,
    required this.especialista,
  });

  void _mostrarAgendarCita(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AgendarCitaSheet(especialista: especialista),
    );
  }

  Future<void> _llamar(BuildContext context) async {
    if (especialista.telefono == null || especialista.telefono!.isEmpty) return;
    
    final Uri telUri = Uri(
      scheme: 'tel',
      path: especialista.telefono,
    );
    
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir la aplicación de llamadas.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Foto, Nombre, Título e Insignia
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primaryContainer,
                child: Text(
                  especialista.nombre.substring(0, 1),
                  style: AppTypography.headlineMd.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            especialista.nombre,
                            style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        // Status indicator
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: especialista.disponible 
                                ? Colors.green.withValues(alpha: 0.1) 
                                : Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            especialista.disponible ? 'Disponible' : 'Ocupado',
                            style: AppTypography.labelSm.copyWith(
                              color: especialista.disponible ? Colors.green[700] : Colors.red[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      especialista.titulo,
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (especialista.insignia.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            especialista.insignia == 'Especialista Top'
                                ? Icons.verified
                                : Icons.new_releases,
                            size: 14,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            especialista.insignia,
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Especialidades
          Text(
            especialista.especialidadPrincipal,
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: especialista.especialidadesSecundarias.map((esp) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  esp,
                  style: AppTypography.labelSm.copyWith(color: AppColors.onSurface),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0x1A114036)),
          const SizedBox(height: 12),
          
          // Reputación y Stats
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                '${especialista.calificacion} ',
                style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
              Text(
                '(${especialista.numeroCalificaciones} opiniones)',
                style: AppTypography.bodySm.copyWith(fontSize: 11),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('•', style: TextStyle(color: Colors.grey)),
              ),
              Text(
                '${especialista.consultasAtendidas} consultas',
                style: AppTypography.bodySm.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '${especialista.aniosExperiencia} años de experiencia',
                style: AppTypography.bodySm.copyWith(fontSize: 11),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('•', style: TextStyle(color: Colors.grey)),
              ),
              Expanded(
                child: Text(
                  especialista.zonaCobertura,
                  style: AppTypography.bodySm.copyWith(fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            especialista.tiempoRespuestaPromedio,
            style: AppTypography.bodySm.copyWith(
              fontSize: 11, 
              color: AppColors.tertiaryFixedDim,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Acciones
          Row(
            children: [
              if (especialista.telefono != null && especialista.telefono!.isNotEmpty) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: especialista.disponible ? () => _llamar(context) : null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(
                        color: especialista.disponible 
                            ? AppColors.primary 
                            : AppColors.onSurfaceVariant.withValues(alpha: 0.2),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.call, size: 18),
                    label: const Text('Llamar'),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () => _mostrarAgendarCita(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.calendar_month, size: 18),
                  label: const Text('Agendar consulta'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
