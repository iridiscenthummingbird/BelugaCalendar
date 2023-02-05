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
            firstDay: DateTime.now().subtract(const Duration(days: 1000)),
            lastDay: DateTime.now().add(const Duration(days: 1000)),
            selectedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            selectedEvents: null,
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
        ),
      );

  void onPageChanged(DateTime focusedDay) => emit(
        CalendarState(focusedDay: focusedDay),
      );

  void onFormatChanged(CalendarFormat format) => emit(
        CalendarState(calendarFormat: format),
      );
}
