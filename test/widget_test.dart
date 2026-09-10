import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/app.dart';

void main() {
  testWidgets('Brotec app renders with header, active weather calendar route, and 5 destinations', (WidgetTester tester) async {
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

    // Verify header icons
    expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

    // Verify 5 bottom navigation destinations
    expect(find.text('Finca'), findsOneWidget);
    expect(find.text('Calendario'), findsOneWidget);
    expect(find.text('Consultas'), findsOneWidget);
    expect(find.text('Tienda'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);

    // Verify Top Climate Notification
    expect(find.text('Heladas y cambios climáticos'), findsOneWidget);

    // Verify Calendar view elements for current date
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

    // Verify Weather Outlook for other dates
    expect(find.text('Pronóstico de Otras Fechas'), findsOneWidget);

    // Verify Tasks and Add Task modal button are removed
    expect(find.text('Agregar Tarea'), findsNothing);
    expect(find.text('Sin labores programadas'), findsNothing);
  });
}
