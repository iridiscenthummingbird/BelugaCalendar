import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/domain/entities/category.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:dartz/dartz.dart';

abstract class EventsRepositoryI {
  Future<Either<Failure, List<Event>>> getUsersEvents(UserModel user);
  Future<Either<Failure, void>> addEvent(AddEventParameters event);
  Future<Either<Failure, List<Category>>> getCategories();
}