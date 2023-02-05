import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/main/data/models/add_event_model.dart';
import 'package:beluga_calendar/flows/main/data/models/event_model.dart';
import 'package:beluga_calendar/services/firestore/firestore_events.dart';
import 'package:injectable/injectable.dart';

abstract class EventsDataSourceI {
  Future<List<EventModel>> getUsersEvents(UserModel user);
  Future<void> addEvent(AddEventModel event);
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
  Future<void> addEvent(AddEventModel event) async {
    try {
      await firestoreEvents.addEvent(event);
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }
}
