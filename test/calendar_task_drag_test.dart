import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/app.dart';
import 'package:client/features/calendar/domain/models/calendar_task.dart';
import 'package:client/features/calendar/presentation/controllers/calendar_controller.dart';

void main() {
  group('CalendarTask advanceStatus & regressStatus unit tests', () {
    test('Programado -> En Curso -> Completado -> En Curso -> Programado progression', () {
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

      // Advance 1: Programado -> En Curso
      final inProgressTask = task.advanceStatus();
      expect(inProgressTask.status, 'En Curso');
      expect(inProgressTask.isInProgress, true);

      // Advance 2: En Curso -> Completado
      final completedTask = inProgressTask.advanceStatus();
      expect(completedTask.status, 'Completado');
      expect(completedTask.isInProgress, false);

      // Advance 3 (at boundary): stays Completado
      final finalTask = completedTask.advanceStatus();
      expect(finalTask.status, 'Completado');
      expect(finalTask.isInProgress, false);

      // Regress 1: Completado -> En Curso
      final regressedToInProgress = finalTask.regressStatus();
      expect(regressedToInProgress.status, 'En Curso');
      expect(regressedToInProgress.isInProgress, true);

      // Regress 2: En Curso -> Programado
      final regressedToScheduled = regressedToInProgress.regressStatus();
      expect(regressedToScheduled.status, 'Programado');
      expect(regressedToScheduled.isInProgress, false);

      // Regress 3 (at boundary): stays Programado
      final initialBoundary = regressedToScheduled.regressStatus();
      expect(initialBoundary.status, 'Programado');
      expect(initialBoundary.isInProgress, false);
    });
  });

  group('Calendar Task Drag Widget Tests', () {
    testWidgets(
        'Dragging LEFT advances status (Programado -> En Curso -> Completado), dragging RIGHT regresses status',
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

      // 1. Drag task to the LEFT (endToStart) to advance: Programado -> En Curso
      await tester.drag(taskFinder, const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.text('En Curso'), findsWidgets);
      expect(find.textContaining('avanzó a: En Curso'), findsOneWidget);

      // 2. Drag task to the LEFT (endToStart) to advance: En Curso -> Completado
      await tester.drag(taskFinder, const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.text('Completado'), findsWidgets);
      expect(find.textContaining('avanzó a: Completado'), findsOneWidget);

      // 3. Drag task to the LEFT when already Completado
      await tester.drag(taskFinder, const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.text('Completado'), findsWidgets);
      expect(find.text('Esta labor ya ha sido completada.'), findsOneWidget);

      // 4. Drag task to the RIGHT (startToEnd) to reverse: Completado -> En Curso
      await tester.drag(taskFinder, const Offset(500, 0));
      await tester.pumpAndSettle();

      expect(find.text('En Curso'), findsWidgets);
      expect(find.textContaining('regresó a: En Curso'), findsOneWidget);

      // 5. Drag task to the RIGHT (startToEnd) to reverse: En Curso -> Programado
      await tester.drag(taskFinder, const Offset(500, 0));
      await tester.pumpAndSettle();

      expect(find.text('Programado'), findsWidgets);
      expect(find.textContaining('regresó a: Programado'), findsOneWidget);

      // 6. Drag task to the RIGHT when already Programado
      await tester.drag(taskFinder, const Offset(500, 0));
      await tester.pumpAndSettle();

      expect(find.text('Programado'), findsWidgets);
      expect(find.text('Esta labor ya está en estado inicial (Programado).'), findsOneWidget);
    });
  });
}
