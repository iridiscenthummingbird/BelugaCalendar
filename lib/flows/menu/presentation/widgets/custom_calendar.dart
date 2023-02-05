import 'package:beluga_calendar/flows/menu/data/test_data/test_data.dart';
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
            calendarFormat: state.calendarFormat,
            onFormatChanged: (format) =>
                context.read<CalendarCubit>().onFormatChanged(format),
            focusedDay: state.focusedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            onPageChanged: (focusedDay) =>
                context.read<CalendarCubit>().onPageChanged(focusedDay),
            selectedDayPredicate: (day) => isSameDay(day, state.selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(state.selectedDay, selectedDay)) {
                context.read<CalendarCubit>().onDaySelected(
                      selectedDay,
                      focusedDay,
                      _getEventsForDay(focusedDay),
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
            calendarBuilders: _calendarBuilders(),
          ),
        );
      },
    );
  }

  List _getEventsForDay(DateTime day) {
    return TestData.kEvents[day] ?? [];
  }

  CalendarBuilders _calendarBuilders() {
    return CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) => Center(
        child: Text(
          '${day.day}',
          style: _getEventsForDay(day).isNotEmpty
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
