import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/data/models/add_event_model.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:dartz/dartz.dart';

abstract class EventsRepositoryI {
  Future<Either<Failure, List<Event>>> getUsersEvents(UserModel user);
  Future<Either<Failure, void>> addEvent(AddEventModel event);
}