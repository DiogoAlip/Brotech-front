import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/app.dart';

void main() {
  testWidgets('Brotec app renders with header, active calendar route, and 5 destinations', (WidgetTester tester) async {
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
    expect(find.text('Chatbot'), findsOneWidget);
    expect(find.text('Tienda'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);

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
    expect(find.text('Agregar Tarea'), findsOneWidget);
  });
}
