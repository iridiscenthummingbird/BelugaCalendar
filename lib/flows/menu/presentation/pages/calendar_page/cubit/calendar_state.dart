part of 'calendar_cubit.dart';

class CalendarState extends Equatable {
  final DateTime? focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat? calendarFormat;
  final List? selectedEvents;

  const CalendarState({
    this.focusedDay,
    this.selectedDay,
    this.calendarFormat,
    this.selectedEvents,
  });

  @override
  List<Object> get props => [];
}
