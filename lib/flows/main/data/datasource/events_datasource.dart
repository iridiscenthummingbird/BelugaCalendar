import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/data/models/category_model.dart';
import 'package:beluga_calendar/flows/main/data/models/event_model.dart';
import 'package:beluga_calendar/services/firestore/firestore_events.dart';
import 'package:injectable/injectable.dart';

abstract class EventsDataSourceI {
  Future<List<EventModel>> getUsersEvents(UserModel user);
  Future<List<EventModel>> getUsersEventsForMonth(
      UserModel user, DateTime choosenMonth);
  Future<void> addEvent(AddEventParameters event);
  Future<List<CategoryModel>> getCategories();
}

@Injectable(as: EventsDataSourceI)
class EventsDataSourceImpl implements EventsDataSourceI {
  EventsDataSourceImpl({
    required this.firestoreEvents,
  });

  final FirestoreEvents firestoreEvents;

  @override
  Future<List<EventModel>> getUsersEvents(UserModel user) async {
    try {
      final events = await firestoreEvents.getUsersEvents(user.id);
      return events;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Future<void> addEvent(AddEventParameters event) async {
    try {
      await firestoreEvents.addEvent(event);
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final categories = await firestoreEvents.getCategories();
      return categories;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Future<List<EventModel>> getUsersEventsForMonth(
      UserModel user, DateTime choosenMonth) async {
    try {
      final events =
          await firestoreEvents.getUsersEventsForMonth(user.id, choosenMonth);
      return events;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }
}
