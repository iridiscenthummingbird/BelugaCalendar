import 'dart:collection';

import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/menu/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class TestData {
  //Test data
  static final kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: Utils.getHashCode,
  )..addAll({
      DateTime(2023, 2, 9): [
        const Event(
          title: 'Study',
          date: '09.02.2023',
          description: 'Капець',
          category: 'Study',
          time: '22:00',
          participantsIds: [],
        ),
      ],
      DateTime(2023, 2, 18): [
        const Event(
          title: 'Study',
          date: '18.02.2023',
          description: 'Капець45',
          category: 'Study',
          time: '22:00',
          participantsIds: [],
        ),
      ],
      DateTime(2023, 2, 28): [
        const Event(
          title: 'Study',
          date: '28.02.2023',
          description: 'Капець2',
          category: 'Study',
          time: '22:00',
          participantsIds: [],
        ),
      ],
    });
}
