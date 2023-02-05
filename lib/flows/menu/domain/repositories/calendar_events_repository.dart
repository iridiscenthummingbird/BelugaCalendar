import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/menu/domain/entities/calendar_event.dart';
import 'package:dartz/dartz.dart';

abstract class CalendarEventsRepositoryI {
  Future<Either<Failure, List<CalendarEvent>>> getUsersMonthEvents(
    MonthEventsParameters params
  );
}
