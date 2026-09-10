import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/app.dart';
import 'package:client/features/calendar/presentation/controllers/calendar_controller.dart';

void main() {
  testWidgets('Add Task Modal opens, configures priority, time, goal, title, subject and adds task to selected day',
      (WidgetTester tester) async {
    final testDate = DateTime(2025, 5, 20); // A day without pre-seeded tasks

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialCalendarDateProvider.overrideWithValue(testDate),
        ],
        child: const BroTechApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify empty state for date without tasks
    expect(find.text('Sin labores programadas'), findsOneWidget);
    expect(find.text('Programar Labor'), findsOneWidget);

    // 2. Open Add Task Modal via FAB
    final addTaskBtn = find.text('Agregar Tarea');
    await tester.tap(addTaskBtn);
    await tester.pumpAndSettle();

    // 3. Verify modal is displayed with title and fields
    expect(find.text('Agregar Nueva Labor'), findsOneWidget);
    expect(find.text('Título de la Labor *'), findsOneWidget);
    expect(find.text('Asunto / Descripción *'), findsOneWidget);
    expect(find.text('Hora Programada *'), findsOneWidget);
    expect(find.text('Prioridad *'), findsOneWidget);
    expect(find.text('Configuración del Objetivo (Goal)'), findsOneWidget);

    // 4. Configure Title & Subject using keys
    final titleField = find.byKey(const Key('add_task_title_field'));
    await tester.enterText(titleField, 'Fertirrigación Foliar Intensiva');
    await tester.pumpAndSettle();

    final subjectField = find.byKey(const Key('add_task_subject_field'));
    await tester.enterText(subjectField, 'Aplicación de bioestimulante Sector 4');
    await tester.pumpAndSettle();

    // 5. Select Priority (Media)
    final priorityMedia = find.byKey(const Key('add_task_priority_media'));
    await tester.tap(priorityMedia);
    await tester.pumpAndSettle();

    // 6. Scroll and select Goal Kind (Fertirrigación)
    final fertKindChip = find.byKey(const Key('add_task_goal_kind_fertirrigacion'));
    await tester.ensureVisible(fertKindChip);
    await tester.tap(fertKindChip);
    await tester.pumpAndSettle();

    // 7. Scroll and configure Amount field
    final amountField = find.byKey(const Key('add_task_amount_field'));
    await tester.ensureVisible(amountField);
    await tester.enterText(amountField, '5.5 L/Ha');
    await tester.pumpAndSettle();

    // 8. Submit modal
    final submitBtn = find.byKey(const Key('add_task_submit_btn'));
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();

    // 9. Verify task is added to selected day and empty state is replaced by task card
    expect(find.text('Fertirrigación Foliar Intensiva'), findsOneWidget);
    expect(find.textContaining('5.5 L/Ha'), findsWidgets);
    expect(find.text('Media'), findsWidgets);
  });
}
