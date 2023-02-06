import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/core/errors/failures.dart';
import '../../../../domain/core/usecase/usecase.dart';
import '../../../../domain/shared_models/api/user_model.dart';
import '../entities/event.dart';
import '../repositories/events_repository.dart';
import 'dart:core';

@injectable
class GetUsersEventsForMonthUseCase
    implements UseCase<List<Event>, EventsForMonthParams> {
  final EventsRepositoryI repository;

  GetUsersEventsForMonthUseCase(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(EventsForMonthParams params) async {
    return await repository.getUsersEventsForMonth(params);
  }
}

class EventsForMonthParams {
  final UserModel user;
  final DateTime choosedMonth;

  EventsForMonthParams({
    required this.user,
    required this.choosedMonth,
  });
}
