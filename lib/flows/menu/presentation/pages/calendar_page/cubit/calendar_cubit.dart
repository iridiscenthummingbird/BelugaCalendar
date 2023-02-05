import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_state.dart';

@injectable
class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit()
      : super(
          CalendarState(
            focusedDay: DateTime.now(),
            selectedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            selectedEvents: const [],
          ),
        );

  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
    List<dynamic> selectedEvents,
  ) =>
      emit(
        CalendarState(
          selectedDay: selectedDay,
          focusedDay: focusedDay,
          selectedEvents: selectedEvents,
          calendarFormat: super.state.calendarFormat,
        ),
      );

  void onPageChanged(DateTime focusedDay) => emit(
        CalendarState(
          focusedDay: focusedDay,
          selectedDay: super.state.selectedDay,
          selectedEvents: super.state.selectedEvents,
          calendarFormat: super.state.calendarFormat,
        ),
      );

  void onFormatChanged(CalendarFormat format) => emit(
        CalendarState(
          calendarFormat: format,
          focusedDay: super.state.focusedDay,
          selectedDay: super.state.selectedDay,
          selectedEvents: super.state.selectedEvents,
        ),
      );
}
