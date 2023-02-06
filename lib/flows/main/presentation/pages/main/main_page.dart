import 'package:beluga_calendar/flows/main/presentation/pages/add_event/add_event.dart';
import 'package:beluga_calendar/flows/main/presentation/pages/main/cubit/main_page_cubit.dart';
import 'package:beluga_calendar/flows/main/presentation/pages/main/widgets/events_filter_button.dart';
import 'package:beluga_calendar/flows/menu/presentation/widgets/menu_drawer.dart';
import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:beluga_calendar/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:beluga_calendar/services/injectible/injectible_init.dart';
import 'package:beluga_calendar/widgets/circular_loading.dart';
import 'package:beluga_calendar/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String path = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MainPageCubit>()
        ..loadEvents(
            (context.read<AppStateCubit>().state as AuthorizedState).user),
      child: Builder(builder: (context) {
        return Scaffold(
          drawer: const MenuDrawer(),
          body: SafeArea(
            child: BlocBuilder<MainPageCubit, MainPageState>(
              builder: (context, state) {
                if (state is EventsLoaded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 16, right: 20),
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
                            EventsFilterButton(
                              categories: state.categories,
                              currentCategoryId: state.selectedCategoryId,
                              onChanged: (value) => context
                                  .read<MainPageCubit>()
                                  .applyFilter(value ?? ''),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.events.length,
                            itemBuilder: (context, index) {
                              final event = state.events[index];
                              if (state.selectedCategoryId.isNotEmpty) {
                                if (event.category.id ==
                                    state.selectedCategoryId) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: EventItem(
                                      id: event.id,
                                      title: event.title,
                                      description: event.description.isNotEmpty
                                          ? event.description
                                          : 'No description.',
                                      category: event.category,
                                      date: event.date,
                                      time: event.time,
                                    ),
                                  );
                                }
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: EventItem(
                                    id: event.id,
                                    title: event.title,
                                    description: event.description.isNotEmpty
                                        ? event.description
                                        : 'No description.',
                                    category: event.category,
                                    date: event.date,
                                    time: event.time,
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is EventsLoading) {
                  return const CircularLoading();
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
          floatingActionButton: SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              onPressed: () async {
                final result = await Routemaster.of(context)
                    .push<bool>(AddEventPage.path)
                    .result;
                if (result ?? false) {
                  context.read<MainPageCubit>().loadEvents(
                        (context.read<AppStateCubit>().state as AuthorizedState)
                            .user,
                      );
                }
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: SvgPicture.asset(
                Assets.icons.addEvent.path,
              ),
            ),
          ),
        );
      }),
    );
  }
}
