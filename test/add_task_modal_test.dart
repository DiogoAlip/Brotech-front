import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/app.dart';
import 'package:client/features/calendar/presentation/controllers/calendar_controller.dart';

void main() {
  testWidgets('Calendar displays weather indicators, has no Add Task modal/FAB, and updates weather upon day selection',
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

    // 1. Verify tasks and Add Task modal/FAB are completely absent
    expect(find.text('Agregar Tarea'), findsNothing);
    expect(find.text('Sin labores programadas'), findsNothing);
    expect(find.text('Agregar Nueva Labor'), findsNothing);
    expect(find.byType(FloatingActionButton), findsNothing);

    // 2. Verify Weather Legend items
    expect(find.text('Soleado'), findsWidgets);
    expect(find.text('Lluvia'), findsWidgets);
    expect(find.text('Riesgo Helada'), findsWidgets);
    expect(find.text('Nublado'), findsWidgets);

    // 3. Verify weather details for initial selected date (May 14)
    expect(find.text('Miércoles, 14 de Mayo'), findsOneWidget);
    expect(find.text('Pronóstico Agrometeorológico • Finca El Roble'), findsOneWidget);

    // 4. Select another day on the grid (e.g. day 16)
    final day16Finder = find.text('16').first;
    await tester.ensureVisible(day16Finder);
    await tester.tap(day16Finder);
    await tester.pumpAndSettle();

    // 5. Verify the weather detail card updated to May 16
    expect(find.text('Viernes, 16 de Mayo'), findsOneWidget);
    expect(find.text('Lluvias Aisladas'), findsWidgets);
  });
}
