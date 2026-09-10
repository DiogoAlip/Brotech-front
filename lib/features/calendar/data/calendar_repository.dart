import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../domain/models/calendar_task.dart';

class CalendarRepository {
  final Map<String, List<CalendarTask>> _tasksByDate = {};

  CalendarRepository() {
    _initSampleData();
  }

  String _dateKey(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  List<CalendarTask> getTasksForDate(DateTime date) {
    final key = _dateKey(date);
    final list = _tasksByDate[key];
    if (list != null) {
      return List.unmodifiable(list);
    }
    return const [];
  }

  bool hasTasksOnDate(DateTime date) {
    final key = _dateKey(date);
    final list = _tasksByDate[key];
    return list != null && list.isNotEmpty;
  }

  void addTaskForDate(DateTime date, CalendarTask task) {
    final key = _dateKey(date);
    if (!_tasksByDate.containsKey(key)) {
      _tasksByDate[key] = [];
    }
    _tasksByDate[key]!.add(task);
  }

  void updateTaskForDate(DateTime date, CalendarTask updatedTask) {
    final key = _dateKey(date);
    final list = _tasksByDate[key];
    if (list != null) {
      final index = list.indexWhere((t) => t.id == updatedTask.id);
      if (index != -1) {
        list[index] = updatedTask;
      }
    }
  }

  void _initSampleData() {
    final sampleTasks = [
      const CalendarTask(
        id: '1',
        time: '07:30 AM',
        title: 'Siembra y Vernalización: Semillas de Tomate San Marzano',
        subtitle: 'Solanum lycopersicum • Certified Lot #SM-2025-A2',
        category: 'Ciclo de Siembra',
        categoryColor: AppColors.tertiaryFixedDim,
        categoryIcon: Icons.yard,
        status: 'Programado',
        statusBgColor: AppColors.surfaceContainer,
        statusTextColor: AppColors.onSurfaceVariant,
        metric1Label: 'Plot 4 - Finca El Roble',
        metric1Icon: Icons.location_on,
        metric2Label: 'Germinación Objetivo: 96%',
        metric2Icon: Icons.science,
        priority: 'Alta',
      ),
      const CalendarTask(
        id: '2',
        time: '10:00 AM',
        title: 'Fertirrigación Bionutritiva: Micorrizas e Inoculante de Nitrógeno',
        subtitle: 'Infusión de potenciador microbiano de suelo vía goteo a alta presión Sector 3.',
        category: 'Fertirrigación',
        categoryColor: AppColors.secondary,
        categoryIcon: Icons.water_drop,
        status: 'Programado',
        statusBgColor: AppColors.surfaceContainer,
        statusTextColor: AppColors.onSurfaceVariant,
        metric1Label: 'Dosis: 4.2 L/Ha',
        metric1Icon: Icons.opacity,
        metric2Label: 'EC: 1.8 mS/cm',
        metric2Icon: Icons.speed,
        isInProgress: false,
        priority: 'Media',
      ),
      const CalendarTask(
        id: '3',
        time: '02:15 PM',
        title: 'Inspección de Germinación y Humedad de Lote de Semillas ISTA',
        subtitle: 'Evaluación Comparativa en Laboratorio Certificado • Greenhouse Unit B',
        category: 'Ensayo de Laboratorio',
        categoryColor: AppColors.primaryContainer,
        categoryIcon: Icons.verified,
        status: 'Programado',
        statusBgColor: AppColors.surfaceContainer,
        statusTextColor: AppColors.onSurfaceVariant,
        metric1Label: 'Cámara: 21.5°C',
        metric1Icon: Icons.thermostat,
        metric2Label: 'Tolerancia Humedad: <7.8%',
        metric2Icon: Icons.percent,
        priority: 'Media',
      ),
      const CalendarTask(
        id: '4',
        time: '04:45 PM',
        title: 'Telemetría y Humedad del Suelo',
        subtitle: 'Reconciliación de escaneo espectral por dron y lecturas de sondas subterráneas.',
        category: 'Telemetría IoT',
        categoryColor: Color(0xFF59DCB5),
        categoryIcon: Icons.sensors,
        status: 'Programado',
        statusBgColor: AppColors.surfaceContainer,
        statusTextColor: AppColors.onSurfaceVariant,
        metric1Label: '14 Sondas Conectadas',
        metric1Icon: Icons.wifi,
        metric2Label: 'pH Promedio: 6.5',
        metric2Icon: Icons.compost,
        priority: 'Baja',
      ),
    ];

    // Seed May 14, 2025 for tests and backward-compatibility
    _tasksByDate['2025-05-14'] = List.from(sampleTasks);

    // Seed Today
    final now = DateTime.now();
    final todayKey = _dateKey(now);
    if (todayKey != '2025-05-14') {
      _tasksByDate[todayKey] = List.from(sampleTasks);
    }

    // Seed tomorrow
    final tomorrow = now.add(const Duration(days: 1));
    _tasksByDate[_dateKey(tomorrow)] = [
      const CalendarTask(
        id: '5',
        time: '09:00 AM',
        title: 'Inspección de Trampas de Feromonas y Control Biológico',
        subtitle: 'Monitoreo de plagas en parcelas de pimiento y berenjena.',
        category: 'Control Fitosanitario',
        categoryColor: AppColors.secondary,
        categoryIcon: Icons.shield,
        status: 'Programado',
        statusBgColor: AppColors.surfaceContainer,
        statusTextColor: AppColors.onSurfaceVariant,
        metric1Label: 'Sector 2B',
        metric1Icon: Icons.location_on,
        metric2Label: 'Umbral de Daño: <2%',
        metric2Icon: Icons.bug_report,
        priority: 'Alta',
      ),
    ];
  }
}
