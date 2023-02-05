part of 'add_event_cubit.dart';

abstract class AddEventState extends Equatable {
  const AddEventState({
    this.date,
    this.time,
  });

  final DateTime? date;
  final TimeOfDay? time;

  @override
  List<Object?> get props => [date, time];
}

class AddEventInitial extends AddEventState {
  const AddEventInitial({
    super.date,
    super.time,
  });
}

class AddEventLoading extends AddEventState {
  const AddEventLoading({
    super.date,
    super.time,
  });
}

class AddEventSuccess extends AddEventState {
  const AddEventSuccess({
    super.date,
    super.time,
  });
}

class AddEventError extends AddEventState {
  const AddEventError({
    required this.failure,
    super.date,
    super.time,
  });

  final Failure failure;
}
