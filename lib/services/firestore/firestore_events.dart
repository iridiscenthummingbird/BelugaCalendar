import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/main/data/models/category_model.dart';
import 'package:beluga_calendar/flows/main/data/models/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

@injectable
class FirestoreEvents {
  FirestoreEvents(this.firebaseFirestore)
      : _eventsCollection = firebaseFirestore.collection('events'),
        _categoriesCollection = firebaseFirestore.collection('categories');

  final FirebaseFirestore firebaseFirestore;

  late final CollectionReference<Map<String, dynamic>> _eventsCollection;
  late final CollectionReference<Map<String, dynamic>> _categoriesCollection;

  Future<EventModel> getEvent(String eventId) async {
    final categories = await getCategories();
    final eventData = await _eventsCollection.doc(eventId).get();
    final category =
        categories.firstWhereOrNull((c) => c.id == eventData['categoryId']) ??
            CategoryModel(
              id: 'EntqdLTYjNqxM6c4uxNT',
              name: 'Study',
              color: const Color(0xffAD00FF),
            );
    final eventModel = EventModel(
      title: eventData['title'],
      ownerId: eventData['ownerId'],
      description: eventData['description'],
      date: DateFormat('dd.MM.yyy').format(eventData['dateTime'].toDate()),
      time: DateFormat.Hm().format(eventData['dateTime'].toDate()),
      dateTime: eventData['dateTime'].toDate(),
      category: category,
      participantsIds: eventData['participantsIds']?.cast<String>().toList() ??
          List<String>.empty(),
      participantsEmails:
          eventData['participantsEmails']?.cast<String>().toList() ??
              List<String>.empty(),
      id: eventId,
      shareLink: eventData['shareCode'],
    );

    return eventModel;
  }

  Future<List<EventModel>> getUsersEvents(String userId) async {
    final categories = await getCategories();
    final result =
        await _eventsCollection.where('ownerId', isEqualTo: userId).get();
    final resultDocs = result.docs;
    final events = resultDocs.map((item) {
      final eventData = item.data();
      final category =
          categories.firstWhereOrNull((c) => c.id == eventData['categoryId']) ??
              CategoryModel(
                id: 'EntqdLTYjNqxM6c4uxNT',
                name: 'Study',
                color: const Color(0xffAD00FF),
              );

      return EventModel(
        title: eventData['title'],
        ownerId: eventData['ownerId'],
        description: eventData['description'],
        date: DateFormat('dd.MM.yyy').format(eventData['dateTime'].toDate()),
        time: DateFormat.Hm().format(eventData['dateTime'].toDate()),
        dateTime: eventData['dateTime'].toDate(),
        // TODO: implement categories
        category: category,
        participantsIds:
            eventData['participantsIds']?.cast<String>().toList() ??
                List<String>.empty(),
        participantsEmails:
            eventData['participantsEmails']?.cast<String>().toList() ??
                List<String>.empty(),
        id: item.id,
        shareLink: eventData['shareCode'],
      );
    }).toList();
    events.sort(
      (a, b) => a.dateTime.compareTo(b.dateTime),
    );

    return events;
  }

  Future<List<EventModel>> getUsersEventsForMonth(
      String userId, DateTime choosedMonth) async {
    final categories = await getCategories();

    final startDate = DateTime(choosedMonth.year, choosedMonth.month);
    final endDate = startDate.add(const Duration(days: 31));

    final result = await _eventsCollection
        .where('ownerId', isEqualTo: userId)
        .where('dateTime', isGreaterThanOrEqualTo: startDate)
        .where('dateTime', isLessThan: endDate)
        .get();

    final resultDocs = result.docs;
    final events = resultDocs.map((item) {
      final eventData = item.data();
      final category =
          categories.firstWhereOrNull((c) => c.id == eventData['categoryId']) ??
              CategoryModel(
                id: 'EntqdLTYjNqxM6c4uxNT',
                name: 'Study',
                color: const Color(0xffAD00FF),
              );

      return EventModel(
        title: eventData['title'],
        ownerId: eventData['ownerId'],
        description: eventData['description'],
        date: DateFormat('dd.MM.yyy').format(eventData['dateTime'].toDate()),
        time: DateFormat.Hm().format(eventData['dateTime'].toDate()),
        dateTime: eventData['dateTime'].toDate(),
        // TODO: implement categories
        category: category,
        participantsIds:
            eventData['participantsIds']?.cast<String>().toList() ??
                List<String>.empty(),
        participantsEmails:
            eventData['participantsEmails']?.cast<String>().toList() ??
                List<String>.empty(),
        id: item.id,
        shareLink: eventData['shareCode'],
      );
    }).toList();
    events.sort(
      (a, b) => a.dateTime.compareTo(b.dateTime),
    );

    return events;
  }

  Future<void> addEvent(AddEventParameters event) async {
    final shareCode = DateTime.now().millisecondsSinceEpoch - 1675690000000;
    await _eventsCollection.add(
      {
        'ownerId': event.ownerId,
        'title': event.title,
        'description': event.description,
        'dateTime': Timestamp.fromDate(event.dateTime),
        'categoryId': event.categoryId,
        'participantsIds': [event.ownerId],
        'participantsEmails': [event.ownerEmail],
        'shareCode': '$shareCode',
      },
    );
  }

  Future<List<CategoryModel>> getCategories() async {
    final result = await _categoriesCollection.get();
    final resultDocs = result.docs;
    final categories = resultDocs.map((c) {
      final categoryData = c.data();

      return CategoryModel(
        id: c.id,
        name: categoryData['name'],
        color: Color(
          categoryData['color'],
        ),
      );
    }).toList();

    return categories;
  }

  Future<void> updateEvent(
    String id,
    String title,
    String description,
    DateTime dateTime,
  ) async {
    await _eventsCollection.doc(id).update(
      {
        'title': title,
        'dateTime': Timestamp.fromDate(dateTime),
        'description': description,
      },
    );
  }
}
