part of 'main_page_cubit.dart';

abstract class MainPageState extends Equatable {
  const MainPageState({
    this.events = const [],
    this.selectedCategoryId = '',
    this.categories = const [],
  });

  final List<Event> events;
  final String selectedCategoryId;
  final List<Category> categories;

  @override
  List<Object> get props => [events, selectedCategoryId];
}

class EventsLoading extends MainPageState {}

class EventsLoaded extends MainPageState {
  const EventsLoaded({
    required super.events,
    super.selectedCategoryId,
    super.categories,
  });
}

class EventsError extends MainPageState {
  const EventsError({
    required this.failure,
  });

  final Failure failure;
}
