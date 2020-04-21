import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'lang/messages_all.dart';

class AppString {
  String languageCode;
  static AppString _instance;

  AppString._newInstance();

  factory AppString() {
    _instance ??= AppString._newInstance();
    return _instance;
  }

  static Future<AppString> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppString()..languageCode = locale.languageCode;
    });
  }

  static AppString of(BuildContext context) {
    return Localizations.of<AppString>(context, AppString);
  }

  String get title {
    return Intl.message('Hello world App',
        name: 'title', desc: 'The application title');
  }

  String get hello {
    return Intl.message('Hello', name: 'hello');
  }
}

class AppStringDelegate extends LocalizationsDelegate<AppString> {
  const AppStringDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt'].contains(locale.languageCode);
  }

  @override
  Future<AppString> load(Locale locale) {
    return AppString.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppString> old) {
    return false;
  }
}
