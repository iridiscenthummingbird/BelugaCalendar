import 'package:beluga_calendar/flows/menu/presentation/pages/calendar_page/cubit/calendar_cubit.dart';
import 'package:beluga_calendar/flows/menu/presentation/widgets/custom_calendar.dart';
import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:beluga_calendar/services/injectible/injectible_init.dart';
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
      appBar: AppBar(title: const Text('Calendar App')),
      body: BlocProvider(
        create: (context) => getIt<CalendarCubit>(),
        child: BlocBuilder<CalendarCubit, CalendarState>(
            builder: (context, state) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 16,
                  bottom: 26,
                ),
                child: CustomCalendar(),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.selectedEvents.length,
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
                        leading: SvgPicture.asset(
                            Assets.icons.userProfileIcon.path,
                            color: Colors.amberAccent),
                        onTap: () => print('${state.selectedEvents[index]}'),
                        title: Text('${state.selectedEvents[index]}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
