import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/data/datasource/events_datasource.dart';
import 'package:beluga_calendar/flows/main/domain/entities/category.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/main/domain/repositories/events_repository.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/add_participant.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/delete_participant.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/get_event.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/update_event.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_events_for_month.dart';

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
      return (Right(result));
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final result = await remoteDataSource.getCategories();
      return (Right(result));
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getUsersEventsForMonth(
      EventsForMonthParams params) async {
    try {
      final result = await remoteDataSource.getUsersEventsForMonth(
        params.user,
        params.choosedMonth,
      );
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, Event>> getEvent(GetEventParams params) async {
    try {
      final result = await remoteDataSource.getEvent(
        params.eventId,
        params.user,
      );
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> updateEvent(UpdateEventParams params) async {
    try {
      final result = await remoteDataSource.updateEvent(
        params.eventId,
        params.title,
        params.description,
        params.dateTime,
      );
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, String>> addParticipant(
      AddParticipantParams params) async {
    try {
      final result = await remoteDataSource.addParticipant(
        shareCode: params.shareCode,
        participantId: params.participantId,
        participantEmail: params.participantEmail,
      );
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> deleteParticipant(
      DeleteParticipantParams params) async {
    try {
      final result = await remoteDataSource.deleteParticipant(
        eventId: params.eventId,
        participantId: params.participantId,
        participantEmail: params.participantEmail,
      );
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(exception);
    }
  }
}
