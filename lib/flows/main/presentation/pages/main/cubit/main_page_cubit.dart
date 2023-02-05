import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/main/domain/usecases/get_users_events.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'main_page_state.dart';

@injectable
class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit({required this.getUsersEvents}) : super(EventsLoading());

  final GetUsersEventsUseCase getUsersEvents;

  Future<void> loadEvents(UserModel user) async {
    final result = await getUsersEvents(user);
    result.fold((failure) {
      emit(
        EventsError(
          failure: failure,
        ),
      );
    }, (eventsList) {
      emit(
        EventsLoaded(
          events: eventsList,
        ),
      );
    });
  }
}
