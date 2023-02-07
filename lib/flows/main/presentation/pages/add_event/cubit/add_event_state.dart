part of 'add_event_cubit.dart';

class AddEventState extends Equatable {
  const AddEventState({
    this.date,
    this.time,
    this.selectedCategoryId,
    this.file,
    this.categories = const [],
  });

  final DateTime? date;
  final TimeOfDay? time;
  final String? selectedCategoryId;
  final List<Category> categories;
  final File? file;

  @override
  List<Object?> get props => [
        date,
        time,
        selectedCategoryId,
        categories,
        file,
      ];

  AddEventState copyWith({
    DateTime? date,
    TimeOfDay? time,
    String? selectedCategoryId,
    List<Category>? categories,
    File? file,
  }) {
    return AddEventState(
      date: date ?? this.date,
      time: time ?? this.time,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      categories: categories ?? this.categories,
      file: file,
    );
  }
}

class CategoriesLoading extends AddEventState {
  const CategoriesLoading();
}

class AddEventInitial extends AddEventState {
  const AddEventInitial({
    super.date,
    super.time,
    super.selectedCategoryId,
    super.categories,
    super.file,
  });
}

class AddEventLoading extends AddEventState {
  const AddEventLoading({
    super.date,
    super.time,
    super.selectedCategoryId,
    super.file,
    super.categories,
  });
}

class AddEventSuccess extends AddEventState {
  const AddEventSuccess({
    super.date,
    super.time,
    super.selectedCategoryId,
    super.file,
    super.categories,
  });
}

class AddEventError extends AddEventState {
  const AddEventError({
    required this.failure,
    super.date,
    super.time,
    super.selectedCategoryId,
    super.file,
    super.categories,
  });

  final Failure failure;
}
