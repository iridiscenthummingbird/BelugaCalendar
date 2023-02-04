import 'package:beluga_calendar/flows/main/data/models/event_model.dart';
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
        date: DateFormat('dd.MM.yyy').format(eventData['dateTime'].toDate() as DateTime),
        time: DateFormat.Hm().format(eventData['dateTime'].toDate()  as DateTime),
        // TODO: implement categories
        category: 'Study',
        participantsIds: eventData['participantsIds'].cast<String>().toList(),
      );
    }).toList();
    return events;
  }
}
