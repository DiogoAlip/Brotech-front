import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/app.dart';
import 'package:client/features/calendar/domain/models/calendar_task.dart';
import 'package:client/features/calendar/presentation/controllers/calendar_controller.dart';

void main() {
  group('CalendarTask advanceStatus unit tests', () {
    test('Programado -> En Curso -> Completado progression', () {
      const task = CalendarTask(
        id: 'test-1',
        time: '08:00',
        title: 'Calibración de Sensores NPK',
        subtitle: 'Lote Norte - Sensor 4B',
        category: 'Fertirriego',
        categoryColor: Color(0xFF006B54),
        categoryIcon: Icons.water_drop,
        status: 'Programado',
        statusBgColor: Color(0xFFE8F5E9),
        statusTextColor: Color(0xFF006B54),
        metric1Label: 'pH 6.2',
        metric1Icon: Icons.analytics,
        metric2Label: 'CE 1.8 dS/m',
        metric2Icon: Icons.speed,
        isInProgress: false,
      );

      expect(task.status, 'Programado');
      expect(task.isInProgress, false);

      // 1st drag/advance -> En Curso
      final inProgressTask = task.advanceStatus();
      expect(inProgressTask.status, 'En Curso');
      expect(inProgressTask.isInProgress, true);

      // 2nd drag/advance -> Completado
      final completedTask = inProgressTask.advanceStatus();
      expect(completedTask.status, 'Completado');
      expect(completedTask.isInProgress, false);

      // 3rd advance -> stays Completado
      final finalTask = completedTask.advanceStatus();
      expect(finalTask.status, 'Completado');
      expect(finalTask.isInProgress, false);
    });
  });

  group('Calendar Task Drag Widget Tests', () {
    testWidgets(
        'Dragging task horizontally advances state from Programado to En Curso to Completado',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDate = DateTime(2025, 5, 14);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            initialCalendarDateProvider.overrideWithValue(testDate),
          ],
          child: const BroTechApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Find the first sample task
      final taskFinder = find.text('Siembra y Vernalización: Semillas de Tomate San Marzano');
      expect(taskFinder, findsOneWidget);
      await tester.ensureVisible(taskFinder);
      await tester.pumpAndSettle();

      // Initial state is "Programado"
      expect(find.text('Programado'), findsWidgets);

      // 1. Drag task to the RIGHT to advance: Programado -> En Curso
      await tester.drag(taskFinder, const Offset(500, 0));
      await tester.pumpAndSettle();

      // State is now "En Curso"
      expect(find.text('En Curso'), findsWidgets);
      expect(find.textContaining('ahora está: En Curso'), findsOneWidget);

      // 2. Drag task to the LEFT to advance: En Curso -> Completado
      await tester.drag(taskFinder, const Offset(-500, 0));
      await tester.pumpAndSettle();

      // State is now "Completado"
      expect(find.text('Completado'), findsWidgets);
      expect(find.textContaining('ahora está: Completado'), findsOneWidget);

      // 3. Drag task again when already Completado
      await tester.drag(taskFinder, const Offset(500, 0));
      await tester.pumpAndSettle();

      // Task remains "Completado" and informs user
      expect(find.text('Completado'), findsWidgets);
      expect(find.text('Esta labor ya ha sido completada.'), findsOneWidget);
    });
  });
}
