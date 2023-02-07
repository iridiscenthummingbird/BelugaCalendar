part of 'edit_event_cubit.dart';

abstract class EditEventState extends Equatable {
  const EditEventState();

  @override
  List<Object> get props => [];
}

class EditEventLoading extends EditEventState {}

class EditEventLoaded extends EditEventState {
  final Event event;

  const EditEventLoaded(this.event);
}

class EditEventError extends EditEventState {
  final Failure failure;

  const EditEventError(this.failure);
}

class EditEventSuccessfulUpdate extends EditEventState {}
