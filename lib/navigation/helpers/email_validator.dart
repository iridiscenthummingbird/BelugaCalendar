import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailValidator {
  static String? validateEmail(String? email, BuildContext context) {
    if ((email?.isEmpty ?? true) || _isEmail(email)) {
      return null;
    }
    return AppLocalizations.of(context).invalidEmail;
  }

  static bool _isEmail(String? email) {
    String mask =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(mask);

    return regExp.hasMatch(email ?? '');
  }
}
