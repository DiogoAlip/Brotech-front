import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/farm/presentation/screens/farm_screen.dart';
import 'package:client/features/shop/presentation/screens/shop_screen.dart';
import 'package:client/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:client/features/profile/presentation/screens/profile_screen.dart';

void main() {
  const widths = [320.0, 360.0, 375.0, 414.0];

  group('CalendarScreen Responsive & Overflow Tests', () {
    for (final width in widths) {
      testWidgets('CalendarScreen does not overflow at width $width', (tester) async {
        tester.view.physicalSize = Size(width, 844.0);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final caughtErrors = <FlutterErrorDetails>[];
        final oldHandler = FlutterError.onError;
        FlutterError.onError = (details) {
          caughtErrors.add(details);
        };

        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: CalendarScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        FlutterError.onError = oldHandler;

        expect(
          caughtErrors.where((e) => e.exceptionAsString().contains('overflowed')).toList(),
          isEmpty,
          reason: 'RenderFlex overflow detected on CalendarScreen at width $width: $caughtErrors',
        );
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('FarmScreen Responsive & Overflow Tests', () {
    for (final width in widths) {
      testWidgets('FarmScreen does not overflow at width $width', (tester) async {
        tester.view.physicalSize = Size(width, 844.0);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final caughtErrors = <FlutterErrorDetails>[];
        final oldHandler = FlutterError.onError;
        FlutterError.onError = (details) {
          caughtErrors.add(details);
        };

        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: FarmScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        FlutterError.onError = oldHandler;

        expect(
          caughtErrors.where((e) => e.exceptionAsString().contains('overflowed')).toList(),
          isEmpty,
          reason: 'RenderFlex overflow detected at width $width: $caughtErrors',
        );
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('ShopScreen Responsive & Overflow Tests', () {
    for (final width in widths) {
      testWidgets('ShopScreen does not overflow at width $width', (tester) async {
        tester.view.physicalSize = Size(width, 844.0);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final caughtErrors = <FlutterErrorDetails>[];
        final oldHandler = FlutterError.onError;
        FlutterError.onError = (details) {
          caughtErrors.add(details);
        };

        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: ShopScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        FlutterError.onError = oldHandler;

        expect(
          caughtErrors.where((e) => e.exceptionAsString().contains('overflowed')).toList(),
          isEmpty,
          reason: 'RenderFlex overflow detected at width $width: $caughtErrors',
        );
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('Accessibility & High Text Scale Tests (textScaler: 1.3)', () {
    testWidgets('CalendarScreen does not overflow with large text scale on 360px device', (tester) async {
      tester.view.physicalSize = const Size(360.0, 844.0);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final caughtErrors = <FlutterErrorDetails>[];
      final oldHandler = FlutterError.onError;
      FlutterError.onError = (details) {
        caughtErrors.add(details);
      };

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(360.0, 844.0),
                textScaler: TextScaler.linear(1.3),
              ),
              child: CalendarScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      FlutterError.onError = oldHandler;

      expect(
        caughtErrors.where((e) => e.exceptionAsString().contains('overflowed')).toList(),
        isEmpty,
        reason: 'RenderFlex overflow detected on CalendarScreen with textScaler 1.3: $caughtErrors',
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('FarmScreen does not overflow with large text scale on 360px device', (tester) async {
      tester.view.physicalSize = const Size(360.0, 844.0);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final caughtErrors = <FlutterErrorDetails>[];
      final oldHandler = FlutterError.onError;
      FlutterError.onError = (details) {
        caughtErrors.add(details);
      };

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(360.0, 844.0),
                textScaler: TextScaler.linear(1.3),
              ),
              child: FarmScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      FlutterError.onError = oldHandler;

      expect(
        caughtErrors.where((e) => e.exceptionAsString().contains('overflowed')).toList(),
        isEmpty,
        reason: 'RenderFlex overflow detected with textScaler 1.3: $caughtErrors',
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('ShopScreen does not overflow with large text scale on 360px device', (tester) async {
      tester.view.physicalSize = const Size(360.0, 844.0);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final caughtErrors = <FlutterErrorDetails>[];
      final oldHandler = FlutterError.onError;
      FlutterError.onError = (details) {
        caughtErrors.add(details);
      };

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(360.0, 844.0),
                textScaler: TextScaler.linear(1.3),
              ),
              child: ShopScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      FlutterError.onError = oldHandler;

      expect(
        caughtErrors.where((e) => e.exceptionAsString().contains('overflowed')).toList(),
        isEmpty,
        reason: 'RenderFlex overflow detected with textScaler 1.3: $caughtErrors',
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('ProfileScreen does not overflow with large text scale on 360px device', (tester) async {
      tester.view.physicalSize = const Size(360.0, 844.0);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final caughtErrors = <FlutterErrorDetails>[];
      final oldHandler = FlutterError.onError;
      FlutterError.onError = (details) {
        caughtErrors.add(details);
      };

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(360.0, 844.0),
                textScaler: TextScaler.linear(1.3),
              ),
              child: ProfileScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      FlutterError.onError = oldHandler;

      expect(
        caughtErrors.where((e) => e.exceptionAsString().contains('overflowed')).toList(),
        isEmpty,
        reason: 'RenderFlex overflow detected on ProfileScreen with textScaler 1.3: $caughtErrors',
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('ProfileScreen Responsive & Overflow Tests', () {
    for (final width in widths) {
      testWidgets('ProfileScreen does not overflow at width $width', (tester) async {
        tester.view.physicalSize = Size(width, 844.0);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final caughtErrors = <FlutterErrorDetails>[];
        final oldHandler = FlutterError.onError;
        FlutterError.onError = (details) {
          caughtErrors.add(details);
        };

        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: ProfileScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        FlutterError.onError = oldHandler;

        expect(
          caughtErrors.where((e) => e.exceptionAsString().contains('overflowed')).toList(),
          isEmpty,
          reason: 'RenderFlex overflow detected at width $width: $caughtErrors',
        );
        expect(tester.takeException(), isNull);
      });
    }
  });
}
