import 'package:beluga_calendar/flows/menu/presentation/pages/calendar_page/calendar_page.dart';
import 'package:beluga_calendar/flows/menu/presentation/pages/find_event/find_event_page.dart';
import 'package:beluga_calendar/flows/menu/presentation/widgets/custom_menu_item.dart';
import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:beluga_calendar/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routemaster/routemaster.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: (MediaQuery.of(context).size.width + 100) / 2,
      backgroundColor: const Color(0xff643FDB),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              SvgPicture.asset(Assets.beluga.path),
              const SizedBox(height: 16),
              Text(
                'Beluga Time',
                style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                      color: Theme.of(context).primaryColorLight,
                    ),
              ),
              const SizedBox(height: 32),
              CustomMenuItem(
                itemText: 'gmail',
                iconPath: Assets.icons.userProfileIcon.path,
              ),
              const SizedBox(height: 12),
              Container(
                height: 1,
                width: double.infinity,
                color: const Color(0xFFFFFFFF).withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              CustomMenuItem(
                itemText: 'Calendar',
                iconPath: Assets.icons.calendarIcon.path,
                // TODO: go to CalendarPage
                onTap: () => Routemaster.of(context).push(CalendarPage.path),
              ),
              const SizedBox(height: 16),
              CustomMenuItem(
                itemText: 'Find Event',
                iconPath: Assets.icons.searchIcon.path,
                // TODO: go to FindEvent(mainPage?)
                onTap: () => Routemaster.of(context).push(FindEventPage.path),
              ),
              const Spacer(),
              CustomMenuItem(
                itemText: 'Log out',
                iconPath: Assets.icons.logOutIcon.path,
                onTap: () => context.read<AppStateCubit>().logOut(),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
