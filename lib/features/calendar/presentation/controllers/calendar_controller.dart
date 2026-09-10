import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/calendar_repository.dart';
import '../../domain/models/calendar_task.dart';

class CalendarState {
  final DateTime selectedDate;
  final bool isMonthView;
  final List<CalendarTask> tasks;

  const CalendarState({
    required this.selectedDate,
    required this.isMonthView,
    required this.tasks,
  });

  CalendarState copyWith({
    DateTime? selectedDate,
    bool? isMonthView,
    List<CalendarTask>? tasks,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      isMonthView: isMonthView ?? this.isMonthView,
      tasks: tasks ?? this.tasks,
    );
  }
}

class CalendarController extends StateNotifier<CalendarState> {
  final CalendarRepository _repository;

  CalendarController(this._repository)
      : super(
          CalendarState(
            selectedDate: DateTime(2025, 5, 14),
            isMonthView: true,
            tasks: _repository.getTasksForDate(DateTime(2025, 5, 14)),
          ),
        );

  void selectDate(DateTime date) {
    state = state.copyWith(
      selectedDate: date,
      tasks: _repository.getTasksForDate(date),
    );
  }

  void toggleView(bool isMonth) {
    state = state.copyWith(isMonthView: isMonth);
  }

  void previousMonth() {
    state = state.copyWith(
      selectedDate: DateTime(state.selectedDate.year, state.selectedDate.month - 1, state.selectedDate.day),
    );
  }

  void nextMonth() {
    state = state.copyWith(
      selectedDate: DateTime(state.selectedDate.year, state.selectedDate.month + 1, state.selectedDate.day),
    );
  }
}

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  return CalendarRepository();
});

final calendarControllerProvider =
    StateNotifierProvider<CalendarController, CalendarState>((ref) {
  final repo = ref.watch(calendarRepositoryProvider);
  return CalendarController(repo);
});
