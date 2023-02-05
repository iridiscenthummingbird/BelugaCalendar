import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class AddEventParameters {
  AddEventParameters({
    required this.ownerId,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.dateTime,
  });

  final String ownerId;
  final String title;
  final String description;
  final String categoryId;
  final DateTime dateTime;
}

class MonthEventsParameters {
  MonthEventsParameters({
    required this.user,
    required this.currentMonth,
  });

  final UserModel user;
  final DateTime currentMonth;
}
