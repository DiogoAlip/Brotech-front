import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/especialista.dart';

class AgendarCitaSheet extends StatefulWidget {
  final Especialista especialista;

  const AgendarCitaSheet({
    super.key,
    required this.especialista,
  });

  @override
  State<AgendarCitaSheet> createState() => _AgendarCitaSheetState();
}

class _AgendarCitaSheetState extends State<AgendarCitaSheet> {
  final _formKey = GlobalKey<FormState>();
  String _modalidadSeleccionada = '';

  final _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.especialista.modalidad.isNotEmpty) {
      _modalidadSeleccionada = widget.especialista.modalidad.first;
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: nextWeek,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Agendar con ${widget.especialista.nombre}',
                        style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.especialista.tarifaConsulta,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Form Fields
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Cultivo / Problema principal',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 16),
                
                // Date Picker Field
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: const InputDecoration(
                    labelText: 'Fecha de la consulta',
                    border: OutlineInputBorder(),
                    hintText: 'Seleccione una fecha (hasta 7 días)',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) => value!.isEmpty ? 'Por favor seleccione una fecha' : null,
                ),
                const SizedBox(height: 16),
                
                // Modalidad
                Text(
                  'Modalidad',
                  style: AppTypography.labelLg,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: widget.especialista.modalidad.map((mod) {
                    final isSelected = _modalidadSeleccionada == mod;
                    return ChoiceChip(
                      label: Text(mod),
                      selected: isSelected,
                      selectedColor: AppColors.primaryContainer,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.onSurface,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _modalidadSeleccionada = mod);
                        }
                      },
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Aquí iría la lógica para guardar/enviar la solicitud
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Solicitud enviada a ${widget.especialista.nombre}'),
                            backgroundColor: AppColors.secondary,
                          ),
                        );
                      }
                    },
                    child: const Text('Solicitar Cita'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
