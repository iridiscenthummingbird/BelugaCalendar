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
        state.copyWith(
          selectedDay: selectedDay,
          focusedDay: focusedDay,
          selectedEvents: selectedEvents,
        ),
      );

  void onPageChanged(DateTime focusedDay) => emit(
        state.copyWith(
          focusedDay: focusedDay,
        ),
      );

  void onFormatChanged(CalendarFormat format) => emit(
        state.copyWith(
          calendarFormat: format,
        ),
      );
}
