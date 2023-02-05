import 'package:beluga_calendar/flows/main/domain/entities/category.dart';

class Event {
  const Event({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.participantsIds,
    // required this.filePathes,
  });

  final String title;
  final String description;
  final String date;
  final String time;
  final Category category;
  final List<String> participantsIds;
  // final List<String> filePathes;
}
