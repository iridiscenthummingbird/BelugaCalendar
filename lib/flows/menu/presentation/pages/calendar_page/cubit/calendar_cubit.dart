import 'dart:collection';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../domain/shared_models/api/user_model.dart';
import '../../../../../main/domain/usecases/get_events_for_month.dart';

part 'calendar_state.dart';

@injectable
class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this.getUsersEventsForMonthUseCase)
      : super(
          CalendarState(
            focusedDay: DateTime.now(),
            selectedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            selectedEvents: const [],
            monthEvents: LinkedHashMap<DateTime, List<Event>>(),
          ),
        );

  final GetUsersEventsForMonthUseCase getUsersEventsForMonthUseCase;

  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
    List<Event> selectedEvents,
  ) =>
      emit(
        state.copyWith(
          selectedDay: selectedDay,
          focusedDay: focusedDay,
          selectedEvents: selectedEvents,
        ),
      );

  void loadMonth(DateTime choosedMonth, UserModel user) async {
    final result = await getUsersEventsForMonthUseCase(
      EventsForMonthParams(
        user: user,
        choosedMonth: choosedMonth,
      ),
    );
    result.fold(
      (failure) {
        print(failure.message);
      },
      (events) {
        final eventMap = LinkedHashMap<DateTime, List<Event>>(
          equals: isSameDay,
        );
        final groupedMap = groupBy(
          events,
          (event) {
            return DateTime(
              event.dateTime.year,
              event.dateTime.month,
              event.dateTime.day,
            );
          },
        );
        eventMap.addAll(groupedMap);
        emit(
          state.copyWith(
            focusedDay: choosedMonth,
            monthEvent: eventMap,
            selectedEvents: groupedMap[DateTime(
              choosedMonth.year,
              choosedMonth.month,
              choosedMonth.day,
            )],
          ),
        );
      },
    );
  }

  void onFormatChanged(CalendarFormat format) => emit(
        state.copyWith(
          calendarFormat: format,
        ),
      );
}
