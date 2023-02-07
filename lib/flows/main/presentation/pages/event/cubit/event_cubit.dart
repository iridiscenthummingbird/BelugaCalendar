import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/get_event.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../domain/shared_models/api/user_model.dart';

part 'event_state.dart';

@injectable
class EventCubit extends Cubit<EventState> {
  EventCubit(this.getEventUseCase) : super(EventLoading());

  final GetEventUseCase getEventUseCase;

  Future<void> loadEvent(String eventId, UserModel user) async {
    final result = await getEventUseCase(
      GetEventParams(
        eventId: eventId,
        user: user,
      ),
    );
    result.fold(
      (failure) {
        emit(EventError(failure));
      },
      (event) {
        emit(EventLoaded(event));
      },
    );
  }
}
