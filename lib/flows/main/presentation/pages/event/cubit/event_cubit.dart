import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/delete_participant.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/get_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../domain/shared_models/api/user_model.dart';

part 'event_state.dart';

@injectable
class EventCubit extends Cubit<EventState> {
  EventCubit(
    this.getEventUseCase,
    this.deleteParticipantUseCase,
  ) : super(EventLoading());

  final GetEventUseCase getEventUseCase;
  final DeleteParticipantUseCase deleteParticipantUseCase;

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

  Future<void> leaveEvent({
    required String eventId,
    required String participantId,
    required String participantEmail,
  }) async {
    final deleteParticipantParams = DeleteParticipantParams(
      eventId: eventId,
      participantId: participantId,
      participantEmail: participantEmail,
    );
    final result = await deleteParticipantUseCase(deleteParticipantParams);
    result.fold(
      (failure) {
        emit(EventError(failure));
      },
      (result) {
        emit(EventLeft());
      },
    );
  }
}
