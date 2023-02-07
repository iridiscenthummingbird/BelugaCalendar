import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/main/domain/repositories/events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteParticipantUseCase
    implements UseCase<void, DeleteParticipantParams> {
  final EventsRepositoryI repository;

  DeleteParticipantUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteParticipantParams params) async {
    return await repository.deleteParticipant(params);
  }
}

class DeleteParticipantParams {
  final String eventId;
  final String participantId;
  final String participantEmail;

  DeleteParticipantParams({
    required this.eventId,
    required this.participantId,
    required this.participantEmail,
  });
}
