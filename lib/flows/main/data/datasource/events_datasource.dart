import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/data/models/category_model.dart';
import 'package:beluga_calendar/flows/main/data/models/event_model.dart';
import 'package:beluga_calendar/services/firestore/firestore_events.dart';
import 'package:injectable/injectable.dart';

abstract class EventsDataSourceI {
  Future<List<EventModel>> getUsersEvents(UserModel user);
  Future<EventModel> getEvent(String eventId, UserModel user);
  Future<List<EventModel>> getUsersEventsForMonth(
      UserModel user, DateTime choosenMonth);
  Future<void> addEvent(AddEventParameters event);
  Future<void> updateEvent(
    String id,
    String title,
    String description,
    DateTime dateTime,
  );
  Future<void> addParticipant({
    required String shareCode,
    required String participantId,
    required String participantEmail,
  });

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

  @override
  Future<EventModel> getEvent(String eventId, UserModel user) async {
    try {
      final event = await firestoreEvents.getEvent(eventId);

      if (event.participantsIds.contains(user.id)) {
        return event;
      } else {
        throw Exception('You don\'t have access to this event.');
      }
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Future<void> updateEvent(
    String id,
    String title,
    String description,
    DateTime dateTime,
  ) async {
    try {
      await firestoreEvents.updateEvent(
        id,
        title,
        description,
        dateTime,
      );
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Future<void> addParticipant({
    required String shareCode,
    required String participantId,
    required String participantEmail,
  }) async {
    try {
      await firestoreEvents.addParticipant(
        shareCode: shareCode,
        participantId: participantId,
        participantEmail: participantEmail,
      );
    } catch (exception) {
      throw ServerFailure(message: '$exception');
    }
  }
}
