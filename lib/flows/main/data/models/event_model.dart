import 'package:beluga_calendar/flows/main/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required super.title,
    required super.description,
    required super.date,
    required super.time,
    required super.category,
    required super.participantsIds,
    required this.dateTime,
  });

  final DateTime dateTime;
}
