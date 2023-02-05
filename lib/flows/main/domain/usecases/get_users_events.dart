import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/main/domain/repositories/events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUsersEventsUseCase implements UseCase<List<Event>, UserModel> {
  final EventsRepositoryI repository;

  GetUsersEventsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(UserModel user) async {
    return await repository.getUsersEvents(user);
  }
}