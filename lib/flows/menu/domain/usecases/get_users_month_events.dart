import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/menu/domain/entities/calendar_event.dart';
import 'package:beluga_calendar/flows/menu/domain/repositories/calendar_events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUsersMonthEventsUseCase
    implements UseCase<List<CalendarEvent>, MonthEventsParameters> {
  final CalendarEventsRepositoryI repository;

  GetUsersMonthEventsUseCase(this.repository);

  @override
  Future<Either<Failure, List<CalendarEvent>>> call(
      MonthEventsParameters params) async {
    return await repository.getUsersMonthEvents(
        params);
  }
}
