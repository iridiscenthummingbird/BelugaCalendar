import 'package:beluga_calendar/flows/menu/domain/entities/calendar_event.dart';

class CalendarEventModel extends CalendarEvent {
  CalendarEventModel({
    required super.focusedDay,
    required super.selectedDay,
    required super.calendarFormat,
    required super.selectedEvents,
    required super.monthEvents,
  });
}
