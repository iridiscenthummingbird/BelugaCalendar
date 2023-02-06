import 'package:beluga_calendar/flows/main/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.ownerId,
    required super.title,
    required super.shareLink,
    required super.description,
    required super.date,
    required super.time,
    required super.category,
    required super.participantsIds,
    required super.participantsEmails,
    required super.dateTime,
  });
}
