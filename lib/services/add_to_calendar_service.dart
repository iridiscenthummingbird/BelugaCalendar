import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:beluga_calendar/flows/main/domain/entities/event.dart'
    as project;

class AddToCalendarService {
  static void addToCalendar(project.Event event) {
    final calendarEvent = Event(
      startDate: event.dateTime,
      endDate: event.dateTime.add(const Duration(hours: 1)),
      title: event.title,
      description: event.description,
    );
    Add2Calendar.addEvent2Cal(calendarEvent);
  }
}
