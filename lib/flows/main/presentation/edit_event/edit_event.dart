import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../navigation/app_state_cubit/app_state_cubit.dart';
import '../../../../services/injectible/injectible_init.dart';
import '../pages/add_event/widgets/create_button.dart';
import '../pages/add_event/widgets/event_field.dart';
import '../pages/add_event/widgets/picker_field.dart';
import 'cubit/edit_event_cubit.dart';

class EditEventPage extends StatelessWidget {
  const EditEventPage({
    required this.eventId,
    super.key,
  });

  static const String path = '/edit_event';

  final String eventId;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;
    final focusNode = FocusNode();
    return BlocProvider(
      create: (context) => getIt<EditEventCubit>()..loadEvent(eventId, user),
      child: Builder(
        builder: (context) {
          return BlocListener<EditEventCubit, EditEventState>(
            listener: (context, state) {
              if (state is EditEventError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.failure.message),
                  ),
                );
              } else if (state is EditEventSuccessfulUpdate) {
                Routemaster.of(context).pop(true);
              }
            },
            child: BlocBuilder<EditEventCubit, EditEventState>(
              builder: (context, state) {
                if (state is EditEventLoaded) {
                  DateTime dateTime = state.event.dateTime;
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Edit event'),
                      leading: IconButton(
                        onPressed: () => Routemaster.of(context).pop(),
                        icon: SvgPicture.asset(
                          Assets.icons.back.path,
                          height: 24,
                          width: 24,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      titleSpacing: 0,
                      leadingWidth: 52,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: context.read<EditEventCubit>().formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              EventField(
                                title: 'Event name',
                                controller: context
                                    .read<EditEventCubit>()
                                    .titleController,
                                validator: (input) {
                                  if (input?.isEmpty ?? true) {
                                    return 'The filed should not be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 13),
                                      child: PickerField(
                                        controller: context
                                            .read<EditEventCubit>()
                                            .dateController,
                                        onPressed: () async {
                                          final date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2023),
                                            lastDate: DateTime(
                                              DateTime.now().year + 10,
                                            ),
                                            builder: (context, child) {
                                              return Theme(
                                                data: ThemeData(
                                                  colorScheme:
                                                      ColorScheme.light(
                                                    primary: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if (date != null) {
                                            context
                                                    .read<EditEventCubit>()
                                                    .dateController
                                                    .text =
                                                DateFormat('dd.MM.yyy')
                                                    .format(date);

                                            dateTime = DateTime(
                                              date.year,
                                              date.month,
                                              date.day,
                                              dateTime.hour,
                                              dateTime.minute,
                                            );
                                          }
                                        },
                                        iconPath: Assets.icons.date.path,
                                        validator: (input) {
                                          if (input == null) {
                                            return 'Date should not be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 13),
                                      child: PickerField(
                                        controller: context
                                            .read<EditEventCubit>()
                                            .timeController,
                                        onPressed: () async {
                                          final time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            builder: (context, child) {
                                              return Theme(
                                                data: ThemeData(
                                                  timePickerTheme:
                                                      const TimePickerThemeData(
                                                    dialBackgroundColor:
                                                        Colors.white,
                                                  ),
                                                  colorScheme:
                                                      ColorScheme.light(
                                                    primary: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if (time != null) {
                                            context
                                                .read<EditEventCubit>()
                                                .timeController
                                                .text = time.format(context);
                                            dateTime = DateTime(
                                              dateTime.year,
                                              dateTime.month,
                                              dateTime.day,
                                              time.hour,
                                              time.minute,
                                            );
                                          }
                                        },
                                        iconPath: Assets.icons.time.path,
                                        validator: (input) {
                                          if (input == null) {
                                            return 'Time should not be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              EventField(
                                title: 'Description',
                                controller: context
                                    .read<EditEventCubit>()
                                    .descriptionController,
                                focusNode: focusNode,
                                maxLength: 200,
                                maxLines: 4,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 84, top: 10),
                                child: CreateButton(
                                  title: 'Edit',
                                  onPressed: () async {
                                    final formState = context
                                        .read<EditEventCubit>()
                                        .formKey
                                        .currentState;
                                    if (formState?.validate() ?? false) {
                                      context
                                          .read<EditEventCubit>()
                                          .updateEvent(eventId, dateTime);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
