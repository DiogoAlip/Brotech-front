import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/calendar_repository.dart';
import '../../domain/models/daily_weather.dart';

class CalendarState {
  final DateTime selectedDate;
  final bool isMonthView;
  final bool isSelectingMonthYear;
  final int viewingYear;
  final DailyWeather selectedWeather;
  final List<DailyWeather> upcomingWeather;
  final bool isClimateAlertDismissed;

  const CalendarState({
    required this.selectedDate,
    required this.isMonthView,
    this.isSelectingMonthYear = false,
    required this.viewingYear,
    required this.selectedWeather,
    required this.upcomingWeather,
    this.isClimateAlertDismissed = false,
  });

  CalendarState copyWith({
    DateTime? selectedDate,
    bool? isMonthView,
    bool? isSelectingMonthYear,
    int? viewingYear,
    DailyWeather? selectedWeather,
    List<DailyWeather>? upcomingWeather,
    bool? isClimateAlertDismissed,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      isMonthView: isMonthView ?? this.isMonthView,
      isSelectingMonthYear: isSelectingMonthYear ?? this.isSelectingMonthYear,
      viewingYear: viewingYear ?? this.viewingYear,
      selectedWeather: selectedWeather ?? this.selectedWeather,
      upcomingWeather: upcomingWeather ?? this.upcomingWeather,
      isClimateAlertDismissed:
          isClimateAlertDismissed ?? this.isClimateAlertDismissed,
    );
  }
}

class CalendarController extends StateNotifier<CalendarState> {
  final CalendarRepository _repository;

  CalendarController(this._repository, [DateTime? initialDate])
      : super(_buildInitialState(_repository, initialDate));

  static CalendarState _buildInitialState(CalendarRepository repo, [DateTime? initialDate]) {
    final now = initialDate ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return CalendarState(
      selectedDate: today,
      isMonthView: true,
      isSelectingMonthYear: false,
      viewingYear: today.year,
      selectedWeather: repo.getWeatherForDate(today),
      upcomingWeather: repo.getUpcomingForecast(today.add(const Duration(days: 1)), days: 7),
      isClimateAlertDismissed: false,
    );
  }

  void selectDate(DateTime date) {
    state = state.copyWith(
      selectedDate: date,
      viewingYear: date.year,
      selectedWeather: _repository.getWeatherForDate(date),
      upcomingWeather: _repository.getUpcomingForecast(date.add(const Duration(days: 1)), days: 7),
    );
  }

  DailyWeather getWeatherForDate(DateTime date) {
    return _repository.getWeatherForDate(date);
  }

  bool hasFrostRiskOnDate(DateTime date) {
    return _repository.hasFrostRiskOnDate(date);
  }

  void toggleView(bool isMonth) {
    state = state.copyWith(isMonthView: isMonth);
  }

  void toggleMonthYearSelector([bool? show]) {
    final willShow = show ?? !state.isSelectingMonthYear;
    state = state.copyWith(
      isSelectingMonthYear: willShow,
      viewingYear: state.selectedDate.year,
    );
  }

  void setViewingYear(int year) {
    state = state.copyWith(viewingYear: year);
  }

  void previousYear() {
    state = state.copyWith(viewingYear: state.viewingYear - 1);
  }

  void nextYear() {
    state = state.copyWith(viewingYear: state.viewingYear + 1);
  }

  void selectMonthAndYear(int year, int month) {
    final maxDays = DateTime(year, month + 1, 0).day;
    final day = state.selectedDate.day.clamp(1, maxDays);
    final newDate = DateTime(year, month, day);
    state = state.copyWith(
      selectedDate: newDate,
      viewingYear: year,
      isSelectingMonthYear: false,
      selectedWeather: _repository.getWeatherForDate(newDate),
      upcomingWeather: _repository.getUpcomingForecast(newDate.add(const Duration(days: 1)), days: 7),
    );
  }

  void selectMonth(int month) {
    selectMonthAndYear(state.viewingYear, month);
  }

  void selectYear(int year) {
    final maxDays = DateTime(year, state.selectedDate.month + 1, 0).day;
    final day = state.selectedDate.day.clamp(1, maxDays);
    final newDate = DateTime(year, state.selectedDate.month, day);
    state = state.copyWith(
      selectedDate: newDate,
      viewingYear: year,
      selectedWeather: _repository.getWeatherForDate(newDate),
      upcomingWeather: _repository.getUpcomingForecast(newDate.add(const Duration(days: 1)), days: 7),
    );
  }

  void previousMonth() {
    if (state.isSelectingMonthYear) {
      previousYear();
      return;
    }
    if (!state.isMonthView) {
      selectDate(state.selectedDate.subtract(const Duration(days: 7)));
      return;
    }
    int year = state.selectedDate.year;
    int month = state.selectedDate.month - 1;
    if (month < 1) {
      month = 12;
      year--;
    }
    final maxDays = DateTime(year, month + 1, 0).day;
    final day = state.selectedDate.day.clamp(1, maxDays);
    selectDate(DateTime(year, month, day));
  }

  void nextMonth() {
    if (state.isSelectingMonthYear) {
      nextYear();
      return;
    }
    if (!state.isMonthView) {
      selectDate(state.selectedDate.add(const Duration(days: 7)));
      return;
    }
    int year = state.selectedDate.year;
    int month = state.selectedDate.month + 1;
    if (month > 12) {
      month = 1;
      year++;
    }
    final maxDays = DateTime(year, month + 1, 0).day;
    final day = state.selectedDate.day.clamp(1, maxDays);
    selectDate(DateTime(year, month, day));
  }

  void goToToday() {
    final now = DateTime.now();
    selectDate(DateTime(now.year, now.month, now.day));
    if (state.isSelectingMonthYear) {
      state = state.copyWith(isSelectingMonthYear: false);
    }
  }

  void dismissClimateAlert() {
    state = state.copyWith(isClimateAlertDismissed: true);
  }

  void showClimateAlert() {
    state = state.copyWith(isClimateAlertDismissed: false);
  }
}

final initialCalendarDateProvider = Provider<DateTime?>((ref) => null);

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  return CalendarRepository();
});

final calendarControllerProvider =
    StateNotifierProvider<CalendarController, CalendarState>((ref) {
  final repo = ref.watch(calendarRepositoryProvider);
  final initialDate = ref.watch(initialCalendarDateProvider);
  return CalendarController(repo, initialDate);
});
