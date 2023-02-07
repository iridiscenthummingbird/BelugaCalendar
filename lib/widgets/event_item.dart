import 'package:beluga_calendar/flows/main/domain/entities/category.dart';
import 'package:beluga_calendar/flows/main/presentation/pages/event/event_page.dart';
import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    required this.title,
    required this.id,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    super.key,
  });

  final String id;
  final String title;
  final String description;
  final Category category;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          String path = Routemaster.of(context).currentRoute.path;
          if (path == '/') {
            path = '';
          }
          Routemaster.of(context).push(
            path + EventPage.path,
            queryParameters: {
              'id': id,
            },
          );
        },
        child: Ink(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: category.color,
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(16)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Center(
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 12, 28, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.7),
                          height: 1.7,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Divider(
                          color: Theme.of(context).primaryColor,
                          height: 1,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.icons.date.path),
                          const SizedBox(width: 4),
                          Text(
                            date,
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
                            time,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
