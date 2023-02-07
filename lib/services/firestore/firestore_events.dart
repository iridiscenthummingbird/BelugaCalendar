import 'package:beluga_calendar/domain/core/usecase/usecase.dart';
import 'package:beluga_calendar/flows/main/data/models/category_model.dart';
import 'package:beluga_calendar/flows/main/data/models/event_model.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      file: await getFile(eventData['filePath']),
      fileName: eventData['filePath'],
    );

    return eventModel;
  }

  Future<List<EventModel>> getUsersEvents(String userId) async {
    final categories = await getCategories();
    final result = await _eventsCollection
        .where('participantsIds', arrayContains: userId)
        .get();
    final resultDocs = result.docs;
    final eventsFuture = resultDocs.map((item) async {
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
        file: await getFile(eventData['filePath']),
        fileName: eventData['filePath'],
      );
    }).toList();
    final List<EventModel> events = [];
    for (final future in eventsFuture) {
      events.add(await future);
    }
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
        .where('participantsIds', arrayContains: userId)
        .where('dateTime', isGreaterThanOrEqualTo: startDate)
        .where('dateTime', isLessThan: endDate)
        .get();

    final resultDocs = result.docs;
    final eventsFuture = resultDocs.map((item) async {
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
        file: await getFile(eventData['filePath']),
        fileName: eventData['filePath'],
      );
    }).toList();
    final List<EventModel> events = [];
    for (final future in eventsFuture) {
      events.add(await future);
    }
    events.sort(
      (a, b) => a.dateTime.compareTo(b.dateTime),
    );

    return events;
  }

  Future<void> addEvent(AddEventParameters event) async {
    final shareCode = DateTime.now().millisecondsSinceEpoch - 1675690000000;
    String? filePath = null;
    if (event.file != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final cuted = event.file!.path.split('/');
      final pathForSave =
          '${DateTime.now().millisecondsSinceEpoch}${cuted[cuted.length - 1]}';
      final res = await storageRef.child(pathForSave).putFile(event.file!);
      filePath = res.ref.fullPath;
    }
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
        'filePath': filePath,
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

  Future<XFile?> getFile(String? path) async {
    try {
      if (path != null) {
        final storageRef = FirebaseStorage.instance.ref();
        final data = await storageRef.child(path).getData();
        if (data != null) {
          final file = XFile.fromData(data);
          return file;
        } else {
          return null;
        }
      }
    } catch (_) {}
    return null;
  }

  Future<String> addParticipant({
    required String shareCode,
    required String participantId,
    required String participantEmail,
  }) async {
    final eventDoc =
        (await _eventsCollection.where('shareCode', isEqualTo: shareCode).get())
            .docs;
    if (eventDoc.isNotEmpty) {
      final eventData = eventDoc.first.data();
      final List<String> currentParticipants =
          eventData['participantsIds']?.cast<String>().toList();
      final isParticipantAdded =
          currentParticipants.where((e) => e == participantId).isNotEmpty;
      if (!isParticipantAdded) {
        final eventReference = eventDoc.first.reference;
        eventReference.update({
          'participantsIds': FieldValue.arrayUnion([participantId]),
          'participantsEmails': FieldValue.arrayUnion([participantEmail]),
        });
      } else {
        throw Exception('You are already added to this event');
      }
      return eventDoc.first.id;
    } else {
      throw Exception('Wrong invite code');
    }
  }

  Future<void> deleteParticipant({required String eventId, required String participantId, required String participantEmail}) async {
    final eventDoc = await _eventsCollection.doc(eventId).get();
    eventDoc.reference.update({
      'participantsIds': FieldValue.arrayRemove([participantId]),
      'participantsEmails': FieldValue.arrayRemove([participantEmail]),
    });
  }
}
