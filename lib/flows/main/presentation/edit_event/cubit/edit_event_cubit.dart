import 'package:beluga_calendar/flows/main/domain/usecases/update_event.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/core/errors/failures.dart';
import '../../../../../domain/shared_models/api/user_model.dart';
import '../../../domain/entities/event.dart';
import '../../../domain/usecases/get_event.dart';

part 'edit_event_state.dart';

@injectable
class EditEventCubit extends Cubit<EditEventState> {
  EditEventCubit(
    this.getEventUseCase,
    this.updateEventUseCase,
  ) : super(EditEventLoading());

  final GetEventUseCase getEventUseCase;
  final UpdateEventUseCase updateEventUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> loadEvent(String eventId, UserModel user) async {
    final result = await getEventUseCase(
      GetEventParams(
        eventId: eventId,
        user: user,
      ),
    );
    result.fold(
      (failure) {
        emit(EditEventError(failure));
      },
      (event) {
        emit(EditEventLoaded(event));
        _initControllers(
          event.title,
          event.date,
          event.time,
          event.description,
        );
      },
    );
  }

  void _initControllers(
    String title,
    String date,
    String time,
    String description,
  ) {
    titleController.text = title;
    dateController.text = date;
    timeController.text = time;
    descriptionController.text = description;
  }

  Future<void> updateEvent(String eventId, DateTime dateTime) async {
    final result = await updateEventUseCase(
      UpdateEventParams(
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
        eventId: eventId,
      ),
    );
    result.fold(
      (failure) => null,
      (_) {
        emit(EditEventSuccessfulUpdate());
      },
    );
  }
}
