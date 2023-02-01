import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class AuthRouteMap extends RouteMap {
  AuthRouteMap() : super(onUnknownRoute: _onUnknownRoute, routes: _routes);

  static RouteSettings _onUnknownRoute(String route) => const Redirect('/');
  static final Map<String, PageBuilder> _routes = {
    /// Should always start with [RouteMapInitialPage] to maintain push and link subscription
    // EnterPhonePage.path: (_) => const MaterialPage(
    //       child: RouteMapInitialPage(
    //         child: EnterPhonePage(),
    //       ),
    //     ),
  };
}
