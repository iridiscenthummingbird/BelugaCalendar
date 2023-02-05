part of 'add_event_cubit.dart';

class AddEventState extends Equatable {
  const AddEventState({
    this.date,
    this.time,
    this.selectedCategoryId,
    this.categories = const [],
  });

  final DateTime? date;
  final TimeOfDay? time;
  final String? selectedCategoryId;
  final List<Category> categories;

  @override
  List<Object?> get props => [date, time, selectedCategoryId, categories];

  AddEventState copyWith({
    DateTime? date,
    TimeOfDay? time,
    String? selectedCategoryId,
    List<Category>? categories,
  }) {
    return AddEventState(
      date: date ?? this.date,
      time: time ?? this.time,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      categories: categories ?? this.categories,
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
  });
}

class AddEventLoading extends AddEventState {
  const AddEventLoading({
    super.date,
    super.time,
    super.selectedCategoryId,
    super.categories,
  });
}

class AddEventSuccess extends AddEventState {
  const AddEventSuccess({
    super.date,
    super.time,
    super.selectedCategoryId,
    super.categories,
  });
}

class AddEventError extends AddEventState {
  const AddEventError({
    required this.failure,
    super.date,
    super.time,
    super.selectedCategoryId,
    super.categories,
  });

  final Failure failure;
}
