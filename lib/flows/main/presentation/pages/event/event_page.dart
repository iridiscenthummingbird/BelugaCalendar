import 'package:beluga_calendar/flows/main/presentation/pages/event/cubit/event_cubit.dart';
import 'package:beluga_calendar/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:beluga_calendar/services/contact_service.dart';
import 'package:beluga_calendar/services/injectible/injectible_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../gen/assets.gen.dart';
import '../../edit_event/edit_event.dart';

class EventPage extends StatelessWidget {
  const EventPage({
    required this.eventId,
    super.key,
  });

  static const String path = '/event';

  final String eventId;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;
    final userId = user.id;
    return BlocProvider(
      create: (context) => getIt<EventCubit>()..loadEvent(eventId, user),
      child: Builder(
        builder: (context) {
          return BlocListener<EventCubit, EventState>(
            listener: (context, state) {
              if (state is EventLeft) {
                Routemaster.of(context).pop(true);
              }
              if (state is EventError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.failure.message),
                  ),
                );
              }
            },
            child: BlocBuilder<EventCubit, EventState>(
              builder: (context, state) {
                if (state is EventLoaded) {
                  final event = state.event;
                  return Scaffold(
                    appBar: AppBar(
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
                      title: Text(event.title),
                      actions: [
                        IconButton(
                          onPressed: () {
                            try {
                              ContactService.saveContacts(
                                  event.participantsEmails);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Contacts saved successfully!'),
                                ),
                              );
                            } catch (_) {}
                          },
                          icon: Icon(
                            Icons.contacts,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        if (userId == event.ownerId) ...{
                          IconButton(
                            onPressed: () async {
                              String path =
                                  Routemaster.of(context).currentRoute.path;
                              final result = Routemaster.of(context).push<bool>(
                                path + EditEventPage.path,
                                queryParameters: {
                                  'id': event.id,
                                },
                              );
                              if ((await result.result) == true) {
                                context.read<EventCubit>().loadEvent(
                                      eventId,
                                      user,
                                    );
                              }
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        } else ...{
                          IconButton(
                            onPressed: () async {
                              final user = (context.read<AppStateCubit>().state
                                      as AuthorizedState)
                                  .user;
                              await context.read<EventCubit>().leaveEvent(
                                    eventId: eventId,
                                    participantId: user.id,
                                    participantEmail: user.email!,
                                  );
                            },
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        },
                      ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              'Description: ${event.description}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SvgPicture.asset(Assets.icons.date.path),
                                const SizedBox(width: 4),
                                Text(
                                  event.date,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SvgPicture.asset(Assets.icons.time.path),
                                const SizedBox(width: 4),
                                Text(
                                  event.time,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: event.category.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  event.category.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            ListTile(
                              onTap: () {
                                Share.share(
                                    'I invite you to ${event.title}\nYour event code: ${event.shareLink}');
                              },
                              contentPadding: EdgeInsets.zero,
                              title: Text('Code for share: ${event.shareLink}'),
                              trailing: Icon(
                                Icons.share,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            if (event.fileName != null) ...{
                              Align(
                                child: TextButton(
                                  onPressed: () {
                                    Share.shareXFiles(
                                      [event.file!],
                                      subject: event.fileName,
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.download,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        event.fileName!,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            },
                            Text(
                              'Participants (${event.participantsEmails.length}): ',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: event.participantsEmails.length,
                              itemBuilder: (context, index) {
                                return Text(event.participantsEmails[index]);
                              },
                            ),
                          ],
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
