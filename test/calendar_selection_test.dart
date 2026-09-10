import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/app.dart';
import 'package:client/features/calendar/presentation/controllers/calendar_controller.dart';

void main() {
  testWidgets('Calendar starts with actual current date by default',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: BroTechApp(),
      ),
    );
    await tester.pumpAndSettle();

    final now = DateTime.now();
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    const weekdays = [
      'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
    ];

    final expectedMonthYear = '${months[now.month - 1]} ${now.year}';
    final expectedDayHeader = '${weekdays[now.weekday - 1]}, ${now.day} de ${months[now.month - 1]}';

    expect(find.text(expectedMonthYear), findsOneWidget);
    expect(find.text(expectedDayHeader), findsOneWidget);
  });

  testWidgets('Calendar allows navigating months, opening month/year selector, and selecting different months/years',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialCalendarDateProvider.overrideWithValue(DateTime(2025, 5, 14)),
        ],
        child: const BroTechApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Check initial month and date from override
    expect(find.text('Mayo 2025'), findsOneWidget);
    expect(find.text('Miércoles, 14 de Mayo'), findsOneWidget);

    // 2. Next month navigation
    final nextBtn = find.byIcon(Icons.chevron_right).first;
    await tester.tap(nextBtn);
    await tester.pumpAndSettle();

    expect(find.text('Junio 2025'), findsOneWidget);

    // 3. Previous month navigation (x2 -> April 2025)
    final prevBtn = find.byIcon(Icons.chevron_left).first;
    await tester.tap(prevBtn);
    await tester.pumpAndSettle();
    await tester.tap(prevBtn);
    await tester.pumpAndSettle();

    expect(find.text('Abril 2025'), findsOneWidget);

    // 4. Tap the month/year title to open Month & Year selector
    await tester.tap(find.text('Abril 2025'));
    await tester.pumpAndSettle();

    // Verify 12 month chips appear
    expect(find.text('Ene'), findsOneWidget);
    expect(find.text('Feb'), findsOneWidget);
    expect(find.text('Oct'), findsOneWidget);
    expect(find.text('Dic'), findsOneWidget);
    expect(find.text('2025'), findsWidgets);

    // 5. Select October
    final octFinder = find.text('Oct');
    await tester.ensureVisible(octFinder);
    await tester.tap(octFinder);
    await tester.pumpAndSettle();

    // Returns to day grid and displays Octubre 2025
    expect(find.text('Octubre 2025'), findsOneWidget);

    // 6. Test Week View toggle
    await tester.tap(find.text('Semana'));
    await tester.pumpAndSettle();

    // Test Today ("Hoy") button
    await tester.tap(find.text('Hoy'));
    await tester.pumpAndSettle();

    // Returns to today without crash
    expect(find.byType(Scaffold), findsWidgets);
  });
}
