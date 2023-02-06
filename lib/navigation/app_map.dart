import 'package:beluga_calendar/flows/main/presentation/pages/add_event/add_event.dart';
import 'package:beluga_calendar/flows/main/presentation/pages/event/event_page.dart';
import 'package:beluga_calendar/flows/menu/presentation/pages/calendar_page/calendar_page.dart';
import 'package:beluga_calendar/flows/menu/presentation/pages/find_event/find_event_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import '../flows/main/presentation/edit_event/edit_event.dart';
import '../flows/main/presentation/pages/main/main_page.dart';
import 'helpers/route_map_initial_page.dart';

class AppRouteMap extends RouteMap {
  AppRouteMap()
      : super(
          onUnknownRoute: _onUnknownRoute,
          routes: _routes(),
        );

  static RouteSettings _onUnknownRoute(String route) => const Redirect('/');

  static Map<String, PageBuilder> _routes() {
    return {
      MainPage.path: (_) => _createMaterialPage(
            const RouteMapInitialPage(
              child: MainPage(),
            ),
          ),
      CalendarPage.path: (_) => _createMaterialPage(
            const CalendarPage(),
          ),
      FindEventPage.path: (_) => _createMaterialPage(
            const FindEventPage(),
          ),
      AddEventPage.path: (_) => _createMaterialPage(
            const AddEventPage(),
          ),
      ..._openEvent(),
      ..._openEvent(CalendarPage.path),
    };
  }

  static Map<String, PageBuilder> _openEvent([String path = '']) {
    return {
      path + EventPage.path: (routeData) => _createMaterialPage(
            EventPage(
              eventId: routeData.queryParameters['id'] ?? '',
            ),
          ),
      path + EventPage.path + EditEventPage.path: (routeData) =>
          _createMaterialPage(
            EditEventPage(
              eventId: routeData.queryParameters['id'] ?? '',
            ),
          ),
    };
  }

  static MaterialPage<dynamic> _createMaterialPage(Widget page) {
    return MaterialPage(
      child: page,
      name: page.toString(),
    );
  }
}
