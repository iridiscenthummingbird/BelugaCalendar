import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/menu/data/datasource/calendar_events_datasource.dart';
import 'package:beluga_calendar/flows/menu/domain/entities/calendar_event.dart';
import 'package:beluga_calendar/flows/menu/domain/repositories/calendar_events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: CalendarEventsRepositoryI)
class CalendarEventsRepositoryImpl implements CalendarEventsRepositoryI {
  final CalendarEventsDataSourceI remoteDataSource;

  CalendarEventsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CalendarEvent>>> getUsersMonthEvents(
      MonthEventsParameters params) async {
    try {
      final result = await remoteDataSource.getUsersMonthEvents(params);
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }

}
