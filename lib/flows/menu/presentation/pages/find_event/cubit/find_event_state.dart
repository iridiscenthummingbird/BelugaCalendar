part of 'find_event_cubit.dart';

abstract class FindEventState extends Equatable {
  const FindEventState();

  @override
  List<Object> get props => [];
}

class FindEventInitial extends FindEventState {}

class FindEventLoading extends FindEventState {}

class FindEventSuccess extends FindEventState {}

class FindEventError extends FindEventState {
  const FindEventError({
    required this.failure,
  });

  final Failure failure;
}
