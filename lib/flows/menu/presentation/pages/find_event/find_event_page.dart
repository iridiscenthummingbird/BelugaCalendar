import 'package:beluga_calendar/flows/main/presentation/pages/event/event_page.dart';
import 'package:beluga_calendar/flows/menu/presentation/pages/find_event/widgets/code_textfield.dart';
import 'package:beluga_calendar/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:beluga_calendar/services/injectible/injectible_init.dart';
import 'package:beluga_calendar/widgets/circular_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

import 'cubit/find_event_cubit.dart';

class FindEventPage extends StatelessWidget {
  const FindEventPage({super.key});

  static const String path = '/find_event';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find event'),
      ),
      body: BlocProvider(
        create: (context) => getIt<FindEventCubit>(),
        child: BlocListener<FindEventCubit, FindEventState>(
          listener: (context, state) {
            if (state is FindEventSuccess) {
              Routemaster.of(context).push(
                EventPage.path,
                queryParameters: {
                  'id': state.eventId,
                },
              );
            } else if (state is FindEventError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.message)),
              );
            }
          },
          child: BlocBuilder<FindEventCubit, FindEventState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: context.read<FindEventCubit>().formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Please enter event code that event creator had sent you:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CodeTextField(
                              controller:
                                  context.read<FindEventCubit>().controller,
                            ),
                            const SizedBox(height: 16),
                            Material(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4),
                              child: InkWell(
                                onTap: () {
                                  final isValid = context
                                      .read<FindEventCubit>()
                                      .formKey
                                      .currentState
                                      ?.validate();
                                  final user = (context
                                          .read<AppStateCubit>()
                                          .state as AuthorizedState)
                                      .user;
                                  if (isValid == true) {
                                    context.read<FindEventCubit>().findEvent(
                                          participantId: user.id,
                                          participantEmail: user.email!,
                                        );
                                  }
                                },
                                borderRadius: BorderRadius.circular(4),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Text(
                                        'Find event',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state is FindEventLoading) ...{
                    const CircularLoading(),
                  }
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
