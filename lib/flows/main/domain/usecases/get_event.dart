import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/core/errors/failures.dart';
import '../../../../domain/core/usecase/usecase.dart';
import '../../../../domain/shared_models/api/user_model.dart';
import '../entities/event.dart';
import '../repositories/events_repository.dart';

@injectable
class GetEventUseCase implements UseCase<Event, GetEventParams> {
  final EventsRepositoryI repository;

  GetEventUseCase(this.repository);

  @override
  Future<Either<Failure, Event>> call(GetEventParams params) async {
    return await repository.getEvent(params);
  }
}

class GetEventParams {
  final UserModel user;
  final String eventId;

  GetEventParams({
    required this.user,
    required this.eventId,
  });
}
