import 'package:beluga_calendar/flows/main/domain/entities/category.dart';
import 'package:share_plus/share_plus.dart';

class Event {
  const Event({
    required this.id,
    required this.ownerId,
    required this.shareLink,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.participantsIds,
    required this.participantsEmails,
    required this.dateTime,
    required this.file,
    required this.fileName,
  });

  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String date;
  final String time;
  final String shareLink;
  final Category category;
  final List<String> participantsIds;
  final List<String> participantsEmails;
  final DateTime dateTime;
  final XFile? file;
  final String? fileName;
}
