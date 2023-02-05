part of 'calendar_cubit.dart';

class CalendarState extends Equatable {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final List selectedEvents;

  const CalendarState({
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.selectedEvents,
  });

  @override
  List<Object> get props => [
        focusedDay,
        selectedDay,
        calendarFormat,
        selectedEvents,
      ];

  CalendarState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    CalendarFormat? calendarFormat,
    List? selectedEvents,
  }) {
    return CalendarState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      selectedEvents: selectedEvents ?? this.selectedEvents,
    );
  }
}
