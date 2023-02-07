import 'dart:io';

import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/main/domain/entities/category.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/add_event.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/get_categories.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'add_event_state.dart';

@injectable
class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit({
    required this.addEventUseCase,
    required this.getCategoriesUseCase,
  })  : formKey = GlobalKey<FormState>(),
        titleController = TextEditingController(),
        dateController = TextEditingController(text: 'Date'),
        timeController = TextEditingController(text: 'Time'),
        descriptionController = TextEditingController(),
        super(const CategoriesLoading());

  final AddEventUseCase addEventUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController descriptionController;

  Future<void> loadCategories() async {
    final result = await getCategoriesUseCase(NoParams());
    result.fold(
      (failure) {
        emit(
          AddEventError(
            date: state.date,
            time: state.time,
            selectedCategoryId: state.selectedCategoryId,
            categories: state.categories,
            failure: failure,
            file: state.file,
          ),
        );
      },
      (categories) {
        emit(
          AddEventInitial(
            date: state.date,
            time: state.time,
            selectedCategoryId: state.selectedCategoryId,
            categories: categories,
            file: state.file,
          ),
        );
      },
    );
  }

  void selectCategory(Category category) {
    emit(
      state.copyWith(
        selectedCategoryId: category.id,
        file: state.file,
      ),
    );
  }

  void addEvent({
    required String ownerId,
    required String ownerEmail,
    required String title,
    required String description,
    required DateTime dateTime,
    required String categoryId,
  }) async {
    emit(
      AddEventLoading(
        date: state.date,
        time: state.time,
        selectedCategoryId: state.selectedCategoryId,
        categories: state.categories,
        file: state.file,
      ),
    );
    final event = AddEventParameters(
      ownerId: ownerId,
      ownerEmail: ownerEmail,
      title: title,
      description: description,
      categoryId: categoryId,
      dateTime: dateTime,
      file: state.file,
    );
    final result = await addEventUseCase(event);
    result.fold(
      (failure) {
        emit(
          AddEventError(
            date: state.date,
            time: state.time,
            selectedCategoryId: state.selectedCategoryId,
            categories: state.categories,
            failure: failure,
            file: state.file,
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
        selectedCategoryId: state.selectedCategoryId,
        categories: state.categories,
        file: state.file,
      ),
    );
  }

  void pickTime(TimeOfDay? time, BuildContext context) {
    timeController.text = time != null ? time.format(context) : 'Time';
    emit(
      AddEventInitial(
        date: state.date,
        time: time,
        selectedCategoryId: state.selectedCategoryId,
        categories: state.categories,
        file: state.file,
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

  Future<void> addFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      final length = await file.length();

      if (length < 10485760) {
        emit(state.copyWith(file: file));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File is too large'),
          ),
        );
      }
    }
  }

  Future<void> deleteFile() async {
    emit(state.copyWith(file: null));
  }
}
