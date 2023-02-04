part of 'main_page_cubit.dart';

abstract class MainPageState extends Equatable {
  const MainPageState({this.events = const []});

  final List<Event> events;

  @override
  List<Object> get props => [events];
}

class EventsLoading extends MainPageState {}

class EventsLoaded extends MainPageState {
  const EventsLoaded({required super.events});
}

class EventsError extends MainPageState {
  const EventsError({
    required this.failure,
  });

  final Failure failure;
}
