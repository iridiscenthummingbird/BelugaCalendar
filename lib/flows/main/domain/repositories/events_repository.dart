import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/domain/entities/category.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/add_participant.dart';
import 'package:dartz/dartz.dart';

import '../usecases/get_event.dart';
import '../usecases/get_events_for_month.dart';
import '../usecases/update_event.dart';

abstract class EventsRepositoryI {
  Future<Either<Failure, List<Event>>> getUsersEvents(UserModel user);
  Future<Either<Failure, Event>> getEvent(GetEventParams params);
  Future<Either<Failure, List<Event>>> getUsersEventsForMonth(
      EventsForMonthParams params);
  Future<Either<Failure, void>> addEvent(AddEventParameters event);
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, void>> updateEvent(UpdateEventParams params);
  Future<Either<Failure, void>> addParticipant(AddParticipantParams params);
}
