import 'package:beluga_calendar/flows/main/presentation/pages/add_event/cubit/add_event_cubit.dart';
import 'package:beluga_calendar/flows/main/presentation/pages/add_event/widgets/create_button.dart';
import 'package:beluga_calendar/flows/main/presentation/pages/add_event/widgets/picker_field.dart';
import 'package:beluga_calendar/flows/main/presentation/pages/add_event/widgets/event_field.dart';
import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:beluga_calendar/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:beluga_calendar/services/injectible/injectible_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';

class AddEventPage extends StatelessWidget {
  const AddEventPage({super.key});

  static const String path = '/add_event';

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create event'),
        leading: InkWell(
          onTap: () => Routemaster.of(context).pop(),
          child: SvgPicture.asset(
            Assets.icons.back.path,
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
        ),
        titleSpacing: 0,
        leadingWidth: 52,
      ),
      body: BlocProvider(
        create: (context) => getIt<AddEventCubit>(),
        child: BlocListener<AddEventCubit, AddEventState>(
          listener: (context, state) {
            if (state is AddEventError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.failure.message,
                  ),
                ),
              );
            } else if (state is AddEventSuccess) {
              Routemaster.of(context).pop(true);
            }
          },
          child: GestureDetector(
            onTap: () {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: BlocBuilder<AddEventCubit, AddEventState>(
                    builder: (context, state) {
                      final addEventCubit = context.read<AddEventCubit>();

                      return Stack(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                          child: Form(
                            key: addEventCubit.formKey,
                            child: Column(
                              children: [
                                EventField(
                                  title: 'Event name',
                                  controller: addEventCubit.titleController,
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
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: PickerField(
                                          controller:
                                              addEventCubit.dateController,
                                          onPressed: () async {
                                            final date = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2023),
                                              lastDate: DateTime(
                                                  DateTime.now().year + 10),
                                            );
                                            addEventCubit.pickDate(date);
                                          },
                                          iconPath: Assets.icons.date.path,
                                          validator: (input) {
                                            if (state.date == null) {
                                              return 'Date should not be empty';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 13),
                                        child: PickerField(
                                          controller:
                                              addEventCubit.timeController,
                                          onPressed: () async {
                                            final time = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            addEventCubit.pickTime(
                                              time,
                                              context,
                                            );
                                          },
                                          iconPath: Assets.icons.time.path,
                                          validator: (input) {
                                            if (state.time == null) {
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
                                  controller:
                                      addEventCubit.descriptionController,
                                  focusNode: focusNode,
                                  maxLength: 200,
                                  maxLines: 4,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 84),
                                  child: CreateButton(
                                    onPressed: () async {
                                      final formState =
                                          addEventCubit.formKey.currentState;
                                      if (formState?.validate() ?? false) {
                                        addEventCubit.addEvent(
                                          ownerId: ((context
                                                  .read<AppStateCubit>()
                                                  .state) as AuthorizedState)
                                              .user
                                              .id,
                                          title: addEventCubit
                                              .titleController.text,
                                          description: addEventCubit
                                              .descriptionController.text,
                                          dateTime: DateTime(
                                            state.date!.year,
                                            state.date!.month,
                                            state.date!.day,
                                            state.time!.hour,
                                            state.time!.minute,
                                          ),
                                          // TODO: add categories
                                          categoryId: '1234',
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (state is AddEventLoading) ...{
                          Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        }
                      ]);
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
}