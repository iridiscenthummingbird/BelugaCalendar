import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatoryKey = GlobalKey<NavigatorState>();

  BuildContext? getContext() {
    return navigatoryKey.currentContext;
  }
}
