import 'dart:collection';

import 'package:beluga_calendar/flows/menu/domain/models/event.dart';
import 'package:beluga_calendar/flows/menu/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class TestData {
  //Test data
  static final kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: Utils.getHashCode,
  )..addAll({
      DateTime(2023, 2, 9): [
        const Event('2'),
        const Event('22'),
        const Event('43'),
      ],
      DateTime(2023, 2, 5): [
        const Event('12'),
        const Event('122'),
        const Event('143'),
      ],
      DateTime(2023, 2, 18): [
        const Event('211111111'),
        const Event('2200'),
        const Event('43yyyyy'),
        const Event('UUUUUUU'),
        const Event('UUUUUUU22'),
        const Event('UUUUUUU21'),
        const Event('UUUUUUU2189'),
        const Event('UUUUUUU21121'),
      ],
    });
}