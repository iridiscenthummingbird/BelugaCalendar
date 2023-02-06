import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/add_participant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'find_event_state.dart';

@injectable
class FindEventCubit extends Cubit<FindEventState> {
  FindEventCubit({
    required this.addParticipantUseCase,
  }) : super(FindEventInitial());

  final AddParticipantUseCase addParticipantUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  Future<void> findEvent({
    required String participantId,
    required String participantEmail,
  }) async {
    emit(
      FindEventLoading(),
    );
    final parameters = AddParticipantParams(
      shareCode: controller.text,
      participantId: participantId,
      participantEmail: participantEmail,
    );
    final result = await addParticipantUseCase(parameters);
    result.fold(
      (failure) {
        emit(
          FindEventError(
            failure: failure,
          ),
        );
      },
      (id) {
        emit(FindEventSuccess(id));
      },
    );
  }
}
