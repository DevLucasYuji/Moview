// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get title {
    return Intl.message(
      'Hello world App',
      name: 'title',
      desc: 'The application title',
      args: [],
    );
  }

  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  String get accountNotExist {
    return Intl.message(
      'This account not exist',
      name: 'accountNotExist',
      desc: '',
      args: [],
    );
  }

  String get passwordWrong {
    return Intl.message(
      'Your password is wrong',
      name: 'passwordWrong',
      desc: '',
      args: [],
    );
  }

  String get emailWrong {
    return Intl.message(
      'Your email is wrong',
      name: 'emailWrong',
      desc: '',
      args: [],
    );
  }

  String get emailInvalid {
    return Intl.message(
      'This field need to be an email',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  String get emptyField {
    return Intl.message(
      'This field must not be empty',
      name: 'emptyField',
      desc: '',
      args: [],
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'), Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}