import 'dart:collection';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/menu/domain/usecases/get_users_month_events.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_state.dart';

@injectable
class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({required this.getUsersMonthEvents})
      : super(
          CalendarState(
            focusedDay: DateTime.now(),
            selectedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            selectedEvents: const [],
            monthEvents: LinkedHashMap<DateTime, List<Event>>(),
          ),
        );

  final GetUsersMonthEventsUseCase getUsersMonthEvents;

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

  Future<void> loadMonthEvents(MonthEventsParameters params) async {
    final result = await getUsersMonthEvents(
      params
    );
    emit(
      state.copyWith(
        focusedDay: params.currentMonth,
      ),
    );
  }

  void onFormatChanged(CalendarFormat format) => emit(
        state.copyWith(
          calendarFormat: format,
        ),
      );
}
