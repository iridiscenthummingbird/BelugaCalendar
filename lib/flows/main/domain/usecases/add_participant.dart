import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/main/domain/repositories/events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddParticipantUseCase implements UseCase<String, AddParticipantParams> {
  final EventsRepositoryI repository;

  AddParticipantUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(AddParticipantParams params) async {
    return await repository.addParticipant(params);
  }
}

class AddParticipantParams {
  final String shareCode;
  final String participantId;
  final String participantEmail;

  AddParticipantParams({
    required this.shareCode,
    required this.participantId,
    required this.participantEmail,
  });
}
