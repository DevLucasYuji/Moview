import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/app_module.dart';
import 'package:Moview/app/bloc/app_bloc.dart';
import 'package:Moview/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class BlocBase<Event, State> extends Bloc<Event, State> {
  static S _s = AppModule.to.getDependency();

  static AppColor _appColor = AppModule.to.getDependency();

  AppBloc appBloc = AppModule.to.getBloc();

  AppColor get color => _appColor;

  S get translator => _s;

  Locale get locale => Locale(Intl.getCurrentLocale());

  getLanguage() => locale.languageCode;

  setLanguage(Locale locale) => S.load(locale);

  @override
  Future<void> close() {
    appBloc.close();
    return super.close();
  }
}
