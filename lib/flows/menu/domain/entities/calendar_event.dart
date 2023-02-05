import 'dart:collection';

import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEvent {
    CalendarEvent({
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.selectedEvents,
    required this.monthEvents,
  });
  
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final List selectedEvents;
  final LinkedHashMap<DateTime, List<Event>> monthEvents;

}
