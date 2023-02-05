import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/data/datasource/events_datasource.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/main/domain/repositories/events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EventsRepositoryI)
class EventsRepositoryImpl implements EventsRepositoryI {
  final EventsDataSourceI remoteDataSource;

  EventsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Event>>> getUsersEvents(UserModel user) async {
    try {
      final result = await remoteDataSource.getUsersEvents(user);
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> addEvent(AddEventParameters event) async {
    try {
      final result = await remoteDataSource.addEvent(event);
      return(Right(result));
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }  
}