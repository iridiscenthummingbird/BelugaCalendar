import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/main/data/models/event_model.dart';
import 'package:beluga_calendar/flows/menu/data/models/calendar_event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class FirestoreEvents {
  FirestoreEvents(this.firebaseFirestore)
      : _eventsCollection = firebaseFirestore.collection('events');

  final FirebaseFirestore firebaseFirestore;

  late final CollectionReference<Map<String, dynamic>> _eventsCollection;

  Future<List<EventModel>> getUsersEvents(String userId) async {
    final result =
        await _eventsCollection.where('ownerId', isEqualTo: userId).get();
    final resultDocs = result.docs;
    final events = resultDocs.map((e) {
      final eventData = e.data();
      return EventModel(
        title: eventData['title'],
        description: eventData['description'],
        date: DateFormat('dd.MM.yyy').format(eventData['dateTime'].toDate()),
        time: DateFormat.Hm().format(eventData['dateTime'].toDate()),
        dateTime: eventData['dateTime'].toDate(),
        // TODO: implement categories
        category: 'Study',
        participantsIds:
            eventData['participantsIds']?.cast<String>().toList() ??
                List<String>.empty(),
      );
    }).toList();
    events.sort(
      (a, b) => a.dateTime.compareTo(b.dateTime),
    );

    return events;
  }

  Future<List<CalendarEventModel>> getUsersMonthEvents(String userId) async {
    final allEvents = await getUsersEvents(userId);
    //CalendarEventModel()
    return [];
  }

  Future<void> addEvent(AddEventParameters event) async {
    await _eventsCollection.add(
      {
        'ownerId': event.ownerId,
        'title': event.title,
        'description': event.description,
        'dateTime': Timestamp.fromDate(event.dateTime),
        // TODO: add categories
        'categoryId': event.categoryId,
      },
    );
  }
}
