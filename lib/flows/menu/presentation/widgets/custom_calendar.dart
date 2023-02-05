import 'dart:collection';

import 'package:beluga_calendar/flows/main/domain/entities/event.dart';
import 'package:beluga_calendar/flows/menu/presentation/pages/calendar_page/cubit/calendar_cubit.dart';
import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final DateTime firstDay = DateTime.now().subtract(const Duration(days: 1000));
  final DateTime lastDay = DateTime.now().add(const Duration(days: 1000));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
            calendarFormat: state.calendarFormat,
            onFormatChanged: (format) =>
                context.read<CalendarCubit>().onFormatChanged(format),
            focusedDay: state.focusedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            onPageChanged: (currentMonth) =>
                context.read<CalendarCubit>().loadMonthEvents(currentMonth),
            selectedDayPredicate: (day) => isSameDay(day, state.selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(state.selectedDay, selectedDay)) {
                context.read<CalendarCubit>().onDaySelected(
                      selectedDay,
                      focusedDay,
                      _getEventsForDay(focusedDay, state.monthEvents),
                    );
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
              todayTextStyle: TextStyle(
                color: Color(0xFF1C1243),
                fontWeight: FontWeight.w500,
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff643FDB),
              ),
              //selectedTextStyle:
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
            calendarBuilders: _calendarBuilders(state.monthEvents),
          ),
        );
      },
    );
  }

  List<Event> _getEventsForDay(
      DateTime day, LinkedHashMap<DateTime, List<Event>> monthEvents) {
    return monthEvents[day] ?? [];
  }

  CalendarBuilders _calendarBuilders(
      LinkedHashMap<DateTime, List<Event>> monthEvents) {
    return CalendarBuilders(
      markerBuilder: (context, day, events) =>
          _getEventsForDay(day, monthEvents).isNotEmpty
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF251460),
                    ),
                  ),
                )
              : null,
      defaultBuilder: (context, day, focusedDay) => Center(
        child: Text(
          '${day.day}',
          style: _getEventsForDay(day, monthEvents).isNotEmpty
              ? Theme.of(context).primaryTextTheme.displayMedium?.copyWith(
                    fontFamily: Assets.fonts.sourceSansProBlack,
                    fontSize: 14,
                    color: const Color(0xFF643FDB),
                    fontWeight: FontWeight.bold,
                  )
              : Theme.of(context).primaryTextTheme.displayMedium?.copyWith(
                    fontSize: 14,
                    color: const Color(0xFF1C1243),
                    fontWeight: FontWeight.w500,
                  ),
        ),
      ),
    );
  }
}
