import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/core/errors/failures.dart';
import '../../../../domain/core/usecase/usecase.dart';
import '../repositories/events_repository.dart';

@injectable
class UpdateEventUseCase implements UseCase<void, UpdateEventParams> {
  final EventsRepositoryI repository;

  UpdateEventUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateEventParams params) async {
    return await repository.updateEvent(params);
  }
}

class UpdateEventParams {
  final String title;
  final DateTime dateTime;
  final String description;
  final String eventId;

  UpdateEventParams({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.eventId,
  });
}
