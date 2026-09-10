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

    // Verify Calendar view elements
    expect(find.text('Mayo 2025'), findsOneWidget);
    expect(find.text('Miércoles, 14 de Mayo'), findsOneWidget);
    expect(find.text('Agregar Tarea'), findsOneWidget);
  });
}
