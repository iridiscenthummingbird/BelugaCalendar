import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/main/domain/repositories/events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddEventUseCase implements UseCase<void, AddEventParameters> {
  final EventsRepositoryI repository;

  AddEventUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddEventParameters event) async {
    return await repository.addEvent(event);
  }
}