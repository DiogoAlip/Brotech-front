import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/app.dart';
import 'package:client/features/calendar/presentation/controllers/calendar_controller.dart';

void main() {
  group('Weather Calendar & Climate Alert Tests', () {
    testWidgets(
        'Displays top notification "Heladas y cambios climáticos", weather metrics for selected date, and allows picking upcoming dates',
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

      // 1. Verify Top Climate Notification Banner
      expect(find.text('Heladas y cambios climáticos'), findsOneWidget);
      expect(find.text('Alerta Activa'), findsOneWidget);
      expect(find.text('Riego por aspersión nocturno'), findsOneWidget);
      expect(find.text('Mantas térmicas en almácigos'), findsOneWidget);

      // 2. Verify Weather metrics for May 14 (Riesgo de Helada)
      expect(find.text('Miércoles, 14 de Mayo'), findsOneWidget);
      expect(find.text('Riesgo de Helada Radiativa'), findsWidgets);
      expect(find.text('Prob. Lluvia'), findsOneWidget);
      expect(find.text('Humedad Rel.'), findsOneWidget);
      expect(find.text('Riesgo Helada'), findsWidgets);
      expect(find.text('Recomendación Agronómica:'), findsOneWidget);

      // 3. Verify Other Dates / Upcoming Forecast
      expect(find.text('Pronóstico de Otras Fechas'), findsOneWidget);
      expect(find.text('Jue 15 May'), findsOneWidget);

      // 4. Tap upcoming date (May 15) to select it
      await tester.tap(find.text('Jue 15 May'));
      await tester.pumpAndSettle();

      // 5. Verify the selected date weather details updated to May 15
      expect(find.text('Jueves, 15 de Mayo'), findsOneWidget);
      expect(find.text('Soleado y Despejado'), findsWidgets);

      // 6. Dismiss top climate banner
      final closeIcon = find.byIcon(Icons.close);
      expect(closeIcon, findsOneWidget);
      await tester.tap(closeIcon);
      await tester.pumpAndSettle();

      // Banner is in compact minimized mode
      expect(find.textContaining('Aviso activo: Heladas y cambios climáticos'), findsOneWidget);

      // Tap to re-expand banner
      await tester.tap(find.textContaining('Aviso activo: Heladas y cambios climáticos'));
      await tester.pumpAndSettle();
      expect(find.text('Medidas preventivas recomendadas:'), findsOneWidget);
    });
  });
}
