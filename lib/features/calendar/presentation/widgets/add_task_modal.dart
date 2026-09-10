import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/calendar_task.dart';
import '../controllers/calendar_controller.dart';

class GoalKindConfig {
  final String key;
  final String label;
  final IconData icon;
  final String category;
  final Color color;
  final List<String> presetGoals;
  final String defaultAmount;

  const GoalKindConfig({
    required this.key,
    required this.label,
    required this.icon,
    required this.category,
    required this.color,
    required this.presetGoals,
    required this.defaultAmount,
  });
}

const List<GoalKindConfig> kGoalKinds = [
  GoalKindConfig(
    key: 'germinacion',
    label: 'Germinación',
    icon: Icons.science,
    category: 'Ciclo de Siembra',
    color: AppColors.tertiaryFixedDim,
    presetGoals: [
      'Germinación Objetivo',
      'Vigor de Plántula',
      'Pureza Física',
      'Tasa de Emergencia',
      'Personalizado...',
    ],
    defaultAmount: '96%',
  ),
  GoalKindConfig(
    key: 'fertirrigacion',
    label: 'Fertirrigación',
    icon: Icons.water_drop,
    category: 'Fertirrigación',
    color: AppColors.secondary,
    presetGoals: [
      'Dosis de Aplicación',
      'Conductividad Eléctrica (EC)',
      'Volumen de Riego',
      'Inyección Nutritiva',
      'Personalizado...',
    ],
    defaultAmount: '4.2 L/Ha',
  ),
  GoalKindConfig(
    key: 'calidad',
    label: 'Calidad & Ensayo',
    icon: Icons.verified,
    category: 'Ensayo de Laboratorio',
    color: AppColors.primaryContainer,
    presetGoals: [
      'Tolerancia de Humedad',
      'Conformidad ISTA',
      'Inspección Fitosanitaria',
      'Pureza Varietal',
      'Personalizado...',
    ],
    defaultAmount: '<7.8%',
  ),
  GoalKindConfig(
    key: 'telemetria',
    label: 'Telemetría IoT',
    icon: Icons.sensors,
    category: 'Telemetría IoT',
    color: Color(0xFF59DCB5),
    presetGoals: [
      'pH Promedio',
      'Lectura de Sondas',
      'Humedad de Suelo',
      'Potencial Hídrico',
      'Personalizado...',
    ],
    defaultAmount: '6.5 pH',
  ),
  GoalKindConfig(
    key: 'nutricion',
    label: 'Nutrición Suelo',
    icon: Icons.opacity,
    category: 'Nutrición de Suelo',
    color: Color(0xFF007058),
    presetGoals: [
      'Contenido de Nitrógeno',
      'Materia Orgánica',
      'Nivel de Fósforo',
      'Dosis Foliar',
      'Personalizado...',
    ],
    defaultAmount: '120 kg/Ha',
  ),
  GoalKindConfig(
    key: 'clima',
    label: 'Clima & Cámara',
    icon: Icons.thermostat,
    category: 'Control Ambiental',
    color: Color(0xFFE65100),
    presetGoals: [
      'Temperatura en Cámara',
      'Humedad Relativa',
      'Radiación Solar',
      'Índice UV',
      'Personalizado...',
    ],
    defaultAmount: '21.5°C',
  ),
  GoalKindConfig(
    key: 'cosecha',
    label: 'Cosecha',
    icon: Icons.eco,
    category: 'Cosecha',
    color: Color(0xFF43A047),
    presetGoals: [
      'Rendimiento Estimado',
      'Densidad de Siembra',
      'Biomasa por Hectárea',
      'Calibre de Fruto',
      'Personalizado...',
    ],
    defaultAmount: '35 Ton/Ha',
  ),
];

class AddTaskModal extends ConsumerStatefulWidget {
  final DateTime selectedDate;

  const AddTaskModal({
    super.key,
    required this.selectedDate,
  });

  static Future<void> show(BuildContext context, DateTime selectedDate) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AddTaskModal(selectedDate: selectedDate),
    );
  }

  @override
  ConsumerState<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends ConsumerState<AddTaskModal> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _subjectController;
  late TextEditingController _timeController;
  late TextEditingController _goalNameController;
  late TextEditingController _goalAmountController;
  late TextEditingController _plotController;

  String _priority = 'Alta';
  late GoalKindConfig _selectedGoalKind;
  String _selectedPreset = 'Germinación Objetivo';

  @override
  void initState() {
    super.initState();
    _selectedGoalKind = kGoalKinds.first;
    _selectedPreset = _selectedGoalKind.presetGoals.first;

    _titleController = TextEditingController(text: 'Siembra y Monitoreo Agronómico');
    _subjectController = TextEditingController(text: 'Inspección técnica de germoplasma en campo experimental');
    _timeController = TextEditingController(text: '08:30 AM');
    _goalNameController = TextEditingController(text: _selectedPreset);
    _goalAmountController = TextEditingController(text: _selectedGoalKind.defaultAmount);
    _plotController = TextEditingController(text: 'Plot 4 - Finca El Roble');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _timeController.dispose();
    _goalNameController.dispose();
    _goalAmountController.dispose();
    _plotController.dispose();
    super.dispose();
  }

  void _onGoalKindChanged(GoalKindConfig newKind) {
    setState(() {
      _selectedGoalKind = newKind;
      _selectedPreset = newKind.presetGoals.first;
      _goalNameController.text = _selectedPreset;
      _goalAmountController.text = newKind.defaultAmount;
    });
  }

  void _onPresetGoalChanged(String? preset) {
    if (preset == null) return;
    setState(() {
      _selectedPreset = preset;
      if (preset != 'Personalizado...') {
        _goalNameController.text = preset;
      } else {
        _goalNameController.clear();
      }
    });
  }

  Future<void> _pickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.secondary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      setState(() {
        _timeController.text = '$hour:$minute $period';
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final goalName = _goalNameController.text.trim().isEmpty
        ? _selectedGoalKind.label
        : _goalNameController.text.trim();
    final goalAmount = _goalAmountController.text.trim();

    final newTask = CalendarTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      time: _timeController.text.trim(),
      title: _titleController.text.trim(),
      subtitle: _subjectController.text.trim(),
      category: _selectedGoalKind.category,
      categoryColor: _selectedGoalKind.color,
      categoryIcon: _selectedGoalKind.icon,
      status: 'Programado',
      statusBgColor: AppColors.surfaceContainer,
      statusTextColor: AppColors.onSurfaceVariant,
      metric1Label: _plotController.text.trim().isNotEmpty
          ? _plotController.text.trim()
          : 'Finca El Roble',
      metric1Icon: Icons.location_on,
      metric2Label: '$goalName: $goalAmount',
      metric2Icon: _selectedGoalKind.icon,
      priority: _priority,
      isInProgress: false,
    );

    ref.read(calendarControllerProvider.notifier).addTask(newTask, widget.selectedDate);

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Labor "${newTask.title}" programada para el ${_formatDateShort(widget.selectedDate)}'),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String _formatDateShort(DateTime date) {
    const months = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    const weekdays = [
      'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
    ];

    final dayName = weekdays[widget.selectedDate.weekday - 1];
    final monthName = months[widget.selectedDate.month - 1];
    final formattedDate = '$dayName, ${widget.selectedDate.day} de $monthName de ${widget.selectedDate.year}';

    return Dialog(
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Modal Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(
                  bottom: BorderSide(color: AppColors.primary.withValues(alpha: 0.1)),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add_task, color: AppColors.secondary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Agregar Nueva Labor',
                          style: AppTypography.headlineSm.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          formattedDate,
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, size: 20, color: AppColors.onSurfaceVariant),
                    tooltip: 'Cerrar',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                ],
              ),
            ),

            // Scrollable Form Body
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Título de la Labor
                      Text(
                        'Título de la Labor *',
                        style: AppTypography.labelMd.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        key: const Key('add_task_title_field'),
                        controller: _titleController,
                        decoration: _inputDecoration(
                          hint: 'Ej: Siembra y Vernalización de Semillas',
                          prefixIcon: Icons.title,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingresa un título para la labor';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // 2. Asunto / Descripción (Subject)
                      Text(
                        'Asunto / Descripción *',
                        style: AppTypography.labelMd.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        key: const Key('add_task_subject_field'),
                        controller: _subjectController,
                        maxLines: 2,
                        decoration: _inputDecoration(
                          hint: 'Ej: Lote #SM-2026 • Evaluación comparativa en invernadero sector 2',
                          prefixIcon: Icons.notes,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingresa el asunto o descripción';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // 3. Hora y Prioridad Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hora
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hora Programada *',
                                  style: AppTypography.labelMd.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  key: const Key('add_task_time_field'),
                                  controller: _timeController,
                                  readOnly: true,
                                  onTap: _pickTime,
                                  decoration: _inputDecoration(
                                    hint: '08:30 AM',
                                    prefixIcon: Icons.access_time,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Prioridad
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Prioridad *',
                                  style: AppTypography.labelMd.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    _buildPriorityOption('Alta', const Color(0xFFBA1A1A), const Key('add_task_priority_alta')),
                                    const SizedBox(width: 4),
                                    _buildPriorityOption('Media', const Color(0xFFB87800), const Key('add_task_priority_media')),
                                    const SizedBox(width: 4),
                                    _buildPriorityOption('Baja', AppColors.secondary, const Key('add_task_priority_baja')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // 4. Parcela / Ubicación (Plot)
                      Text(
                        'Ubicación / Parcela',
                        style: AppTypography.labelMd.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _plotController,
                        decoration: _inputDecoration(
                          hint: 'Ej: Plot 4 - Finca El Roble',
                          prefixIcon: Icons.location_on,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // 5. Configuración del Objetivo (Goal: Kind, Dropdown/Text, Amount)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(_selectedGoalKind.icon, color: AppColors.secondary, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  'Configuración del Objetivo (Goal)',
                                  style: AppTypography.labelMd.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // A. Tipo de Objetivo (Define el Icono)
                            Text(
                              'Tipo de Objetivo (define el icono):',
                              style: AppTypography.labelSm.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: kGoalKinds.map((kind) {
                                  final isSelected = kind.key == _selectedGoalKind.key;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: ChoiceChip(
                                      key: Key('add_task_goal_kind_${kind.key}'),
                                      selected: isSelected,
                                      showCheckmark: false,
                                      avatar: Icon(
                                        kind.icon,
                                        size: 14,
                                        color: isSelected ? Colors.white : kind.color,
                                      ),
                                      label: Text(kind.label),
                                      labelStyle: AppTypography.labelSm.copyWith(
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                        color: isSelected ? Colors.white : AppColors.onSurface,
                                      ),
                                      selectedColor: AppColors.secondary,
                                      backgroundColor: AppColors.surfaceContainerLowest,
                                      side: BorderSide(
                                        color: isSelected
                                            ? AppColors.secondary
                                            : AppColors.primary.withValues(alpha: 0.1),
                                      ),
                                      onSelected: (val) {
                                        if (val) _onGoalKindChanged(kind);
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // B. Dropdown para seleccionar objetivo sugerido
                            Text(
                              'Objetivo (selecciona de la lista o escribe en la casilla):',
                              style: AppTypography.labelSm.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  key: const Key('add_task_goal_dropdown'),
                                  isExpanded: true,
                                  value: _selectedGoalKind.presetGoals.contains(_selectedPreset)
                                      ? _selectedPreset
                                      : _selectedGoalKind.presetGoals.first,
                                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.secondary),
                                  items: _selectedGoalKind.presetGoals.map((preset) {
                                    return DropdownMenuItem<String>(
                                      value: preset,
                                      child: Text(
                                        preset,
                                        style: AppTypography.bodySm.copyWith(
                                          color: AppColors.onSurface,
                                          fontWeight: preset == _selectedPreset
                                              ? FontWeight.w700
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: _onPresetGoalChanged,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // C. Textbox editable para personalizar el nombre del objetivo
                            TextFormField(
                              key: const Key('add_task_goal_name_field'),
                              controller: _goalNameController,
                              onChanged: (val) => setState(() {}),
                              decoration: _inputDecoration(
                                hint: 'Nombre o descripción del objetivo',
                                prefixIcon: _selectedGoalKind.icon,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Por favor especifica el objetivo';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // D. Cantidad / Valor Objetivo (Amount)
                            Text(
                              'Cantidad / Meta Numérica *',
                              style: AppTypography.labelSm.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              key: const Key('add_task_amount_field'),
                              controller: _goalAmountController,
                              onChanged: (val) => setState(() {}),
                              decoration: _inputDecoration(
                                hint: 'Ej: 96%, 4.2 L/Ha, 6.5 pH, 21°C',
                                prefixIcon: Icons.tag,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Por favor especifica la cantidad o valor objetivo';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // E. Live Metric Badge Preview
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
                              ),
                              child: Row(
                                children: [
                                  Icon(_selectedGoalKind.icon, size: 14, color: AppColors.secondary),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Vista Previa: ',
                                    style: AppTypography.labelSm.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${_goalNameController.text.trim().isEmpty ? _selectedGoalKind.label : _goalNameController.text.trim()}: ${_goalAmountController.text.trim().isEmpty ? _selectedGoalKind.defaultAmount : _goalAmountController.text.trim()}',
                                      style: AppTypography.labelSm.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Modal Footer Actions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                border: Border(
                  top: BorderSide(color: AppColors.primary.withValues(alpha: 0.1)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.onSurfaceVariant,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    child: Text(
                      'Cancelar',
                      style: AppTypography.labelMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    key: const Key('add_task_submit_btn'),
                    onPressed: _submit,
                    icon: const Icon(Icons.check, size: 18),
                    label: Text(
                      'Guardar Labor',
                      style: AppTypography.labelMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityOption(String label, Color color, Key key) {
    final isSelected = _priority == label;
    return Expanded(
      child: InkWell(
        key: key,
        onTap: () => setState(() => _priority = label),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.15) : AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isSelected ? color : AppColors.primary.withValues(alpha: 0.15),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTypography.labelSm.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? color : AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.bodySm.copyWith(
        color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
        fontSize: 12,
      ),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, size: 16, color: AppColors.secondary)
          : null,
      prefixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      filled: true,
      fillColor: AppColors.surfaceContainerLowest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.secondary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    );
  }
}
