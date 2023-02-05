import 'package:beluga_calendar/flows/menu/presentation/pages/calendar_page/calendar_page.dart';
import 'package:beluga_calendar/flows/menu/presentation/pages/find_event/find_event_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
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
    };
  }

  static MaterialPage<dynamic> _createMaterialPage(Widget page) {
    return MaterialPage(
      child: page,
      name: page.toString(),
    );
  }
}
