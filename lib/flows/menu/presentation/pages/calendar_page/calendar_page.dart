import 'package:beluga_calendar/flows/menu/presentation/pages/calendar_page/cubit/calendar_cubit.dart';
import 'package:beluga_calendar/flows/menu/presentation/widgets/custom_calendar.dart';
import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:beluga_calendar/services/injectible/injectible_init.dart';
import 'package:beluga_calendar/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  static const String path = '/calendar';

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              getIt<CalendarCubit>()..loadMonthEvents(DateTime.now()),
          child: BlocBuilder<CalendarCubit, CalendarState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, top: 16, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          splashRadius: 20,
                          constraints: const BoxConstraints(),
                          iconSize: 24,
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            Assets.icons.arrowLeftIcon.path,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Calendar',
                          style:
                              Theme.of(context).primaryTextTheme.displayLarge,
                        ),
                        const Spacer(),
                        IconButton(
                          //TODO
                          onPressed: () {},
                          splashRadius: 20,
                          constraints: const BoxConstraints(),
                          iconSize: 24,
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            Assets.icons.dandruffIcon.path,
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          //TODO
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          splashRadius: 20,
                          iconSize: 24,
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            Assets.icons.moreDotsIcon.path,
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 12,
                              bottom: 20,
                            ),
                            child: CustomCalendar(),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.selectedEvents.length,
                              itemBuilder: (context, index) {
                                final event = state.selectedEvents[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: EventItem(
                                    title: event.title,
                                    description: event.description.isNotEmpty
                                        ? event.description
                                        : 'No description.',
                                    category: event.category,
                                    date: event.date,
                                    time: event.time,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
