import 'package:beluga_calendar/domain/core/errors/failures.dart';
import 'package:beluga_calendar/domain/shared_models/api/user_model.dart';
import 'package:beluga_calendar/flows/menu/data/models/calendar_event_model.dart';
import 'package:beluga_calendar/services/firestore/firestore_events.dart';
import 'package:injectable/injectable.dart';

abstract class CalendarEventsDataSourceI {
  Future<List<CalendarEventModel>> getUsersMonthEvents(UserModel user);
}

@Injectable(as: CalendarEventsDataSourceI)
class EventsDataSourceImpl implements CalendarEventsDataSourceI {
  EventsDataSourceImpl({
    required this.firestoreEvents,
  });

  final FirestoreEvents firestoreEvents;

  @override
  Future<List<CalendarEventModel>> getUsersMonthEvents(UserModel user) async {
    try {
      final events = await firestoreEvents.getUsersMonthEvents(user.id);
      return events;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

}
