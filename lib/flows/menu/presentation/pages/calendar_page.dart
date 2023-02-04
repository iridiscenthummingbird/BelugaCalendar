import 'package:beluga_calendar/flows/menu/data/test_data/test_data.dart';
import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late List selectedEvents;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    selectedEvents = _getEventsForDay(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 16,
              bottom: 26,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.transparent,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.08),
                    spreadRadius: 3,
                    blurRadius: 9,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: TableCalendar(
                rowHeight: 40.0,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                focusedDay: _focusedDay,
                firstDay: _firstDay,
                lastDay: _lastDay,
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      selectedEvents = _getEventsForDay(_focusedDay);
                    });
                  }
                },
                headerStyle: HeaderStyle(
                  titleTextFormatter: (date, locale) =>
                      DateFormat.yMMMd(locale).format(date),
                  titleCentered: true,
                  headerPadding: const EdgeInsets.symmetric(vertical: 10),
                  formatButtonVisible: false,
                  rightChevronPadding: EdgeInsets.zero,
                  leftChevronPadding: EdgeInsets.zero,
                  titleTextStyle: const TextStyle(
                    color: Color(0xFF1C1243),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff643FDB),
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1C1243),
                  ),
                  weekendStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1C1243),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedEvents.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(Assets.icons.userProfileIcon.path,
                        color: Colors.amberAccent),
                    onTap: () => print('${selectedEvents[index]}'),
                    title: Text('${selectedEvents[index]}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List _getEventsForDay(DateTime day) {
    return TestData.kEvents[day] ?? [];
  }
}
