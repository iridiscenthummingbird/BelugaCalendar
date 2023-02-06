part of 'event_cubit.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final Event event;

  const EventLoaded(this.event);

  @override
  List<Object> get props => [event];
}

class EventError extends EventState {
  final Failure failure;

  const EventError(this.failure);
}
