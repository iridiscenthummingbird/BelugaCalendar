import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/domain/entities/category.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/get_categories.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/get_users_events.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'main_page_state.dart';

@injectable
class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit({
    required this.getUsersEvents,
    required this.getCategories,
  }) : super(EventsLoading());

  final GetUsersEventsUseCase getUsersEvents;
  final GetCategoriesUseCase getCategories;

  Future<void> loadEvents(UserModel user) async {
    final categories = await _loadCategories();
    if (categories != null) {
      final result = await getUsersEvents(user);
      result.fold(
        (failure) {
          emit(
            EventsError(
              failure: failure,
            ),
          );
        },
        (eventsList) {
          emit(
            EventsLoaded(
              events: eventsList,
              categories: categories
            ),
          );
        },
      );
    } else {
      emit(
        const EventsError(
          failure: ServerFailure(message: 'ERROR: Could not load categories'),
        ),
      );
    }
  }

  Future<List<Category>?> _loadCategories() async {
    final result = await getCategories(NoParams());
    return result.fold(
      (failure) {
        emit(
          EventsError(
            failure: failure,
          ),
        );
        return null;
      },
      (categories) => categories,
    );
  }

  void applyFilter(String categoryId) => emit(
        EventsLoaded(
          events: state.events,
          categories: state.categories,
          selectedCategoryId: categoryId,
        ),
      );
}
