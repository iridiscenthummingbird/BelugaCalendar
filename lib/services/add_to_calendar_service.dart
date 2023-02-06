import 'package:add_2_calendar/add_2_calendar.dart';

import '../domain/core/usecase/usecase.dart';

class AddToCalendarService {
  static void addToCalendar(AddEventParameters event) {
    final calendarEvent = Event(
      startDate: event.dateTime,
      endDate: event.dateTime.add(const Duration(hours: 1)),
      title: event.title,
      description: event.description,
    );
    Add2Calendar.addEvent2Cal(calendarEvent);
  }
}
