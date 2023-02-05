import 'package:beluga_calendar/flows/main/presentation/pages/main/cubit/main_page_cubit.dart';
import 'package:beluga_calendar/flows/main/presentation/pages/main/widgets/events_filter_button.dart';
import 'package:beluga_calendar/flows/menu/presentation/widgets/menu_drawer.dart';
import 'package:beluga_calendar/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:beluga_calendar/services/injectible/injectible_init.dart';
import 'package:beluga_calendar/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      body: BlocProvider(
        create: (context) => getIt<MainPageCubit>()
          ..loadEvents(
              (context.read<AppStateCubit>().state as AuthorizedState).user),
        child: SafeArea(
          child: BlocBuilder<MainPageCubit, MainPageState>(
            builder: (context, state) {
              if (state is EventsLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 16, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                          const Spacer(),
                          EventsFilterButton(onButtonPressed: () {}),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ListView.builder(
                            itemCount: state.events.length,
                            itemBuilder: (context, index) {
                              final event = state.events[index];

                              return EventItem(
                                title: event.title,
                                description: event.description,
                                category: event.category,
                                date: event.date,
                                time: event.time,
                              );
                            },
                          ),
                        ),
                      ),

                      // TextButton(
                      //   onPressed: () {
                      //     context.read<AppStateCubit>().logOut();
                      //   },
                      //   child: const Text('Logout'),
                      // ),
                    ],
                  ),
                );
              } else if (state is EventsLoading) {
                return const Center(child: Text('Loading...'));
              } else if (state is EventsError) {
                return Center(
                  child: Text(
                    'EROOR: ${state.failure.message}',
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
