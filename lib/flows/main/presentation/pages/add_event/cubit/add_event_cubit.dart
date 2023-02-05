import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/flows/main/data/models/add_event_model.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/add_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'add_event_state.dart';

@injectable
class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit({required this.addEventUseCase})
      : formKey = GlobalKey<FormState>(),
        titleController = TextEditingController(),
        dateController = TextEditingController(text: 'Date'),
        timeController = TextEditingController(text: 'Time'),
        descriptionController = TextEditingController(),
        super(const AddEventInitial());

  final AddEventUseCase addEventUseCase;

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController descriptionController;

  void addEvent({
    required String ownerId,
    required String title,
    required String description,
    required DateTime dateTime,
    required String categoryId,
  }) async {
    emit(
      AddEventLoading(
        date: state.date,
        time: state.time,
      ),
    );
    final event = AddEventModel(
      ownerId: ownerId,
      title: title,
      description: description,
      categoryId: categoryId,
      dateTime: dateTime,
    );
    final result = await addEventUseCase(event);
    result.fold(
      (failure) {
        emit(
          AddEventError(
            date: state.date,
            time: state.time,
            failure: failure,
          ),
        );
      },
      (eventsList) {
        emit(const AddEventSuccess());
      },
    );
  }

  void pickDate(DateTime? date) {
    dateController.text =
        date != null ? DateFormat('dd.MM.yyy').format(date) : 'Date';
    emit(
      AddEventInitial(
        date: date,
        time: state.time,
      ),
    );
  }

  void pickTime(TimeOfDay? time, BuildContext context) {
    timeController.text = time != null ? time.format(context) : 'Time';
    emit(
      AddEventInitial(
        date: state.date,
        time: time,
      ),
    );
  }
  
  @override
  Future<void> close() {
    titleController.dispose();
    dateController.dispose();
    timeController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
