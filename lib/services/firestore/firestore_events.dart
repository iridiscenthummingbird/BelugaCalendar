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

  Future<List<EventModel>> getUsersEvents(String userId) async {
    final categories = await getCategories();
    final result =
        await _eventsCollection.where('ownerId', isEqualTo: userId).get();
    final resultDocs = result.docs;
    final events = resultDocs.map((e) {
      final eventData = e.data();
      final category =
          categories.firstWhereOrNull((c) => c.id == eventData['categoryId']) ??
              CategoryModel(
                id: 'EntqdLTYjNqxM6c4uxNT',
                name: 'Study',
                color: const Color(0xffAD00FF),
              );

      return EventModel(
        title: eventData['title'],
        description: eventData['description'],
        date: DateFormat('dd.MM.yyy').format(eventData['dateTime'].toDate()),
        time: DateFormat.Hm().format(eventData['dateTime'].toDate()),
        dateTime: eventData['dateTime'].toDate(),
        // TODO: implement categories
        category: category,
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

  Future<void> addEvent(AddEventParameters event) async {
    await _eventsCollection.add(
      {
        'ownerId': event.ownerId,
        'title': event.title,
        'description': event.description,
        'dateTime': Timestamp.fromDate(event.dateTime),
        'categoryId': event.categoryId,
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
}
