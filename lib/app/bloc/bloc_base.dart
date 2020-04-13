import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/app_module.dart';
import 'package:Moview/app/bloc/app_bloc.dart';
import 'package:Moview/app_string.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class BlocBase<Event, State> extends Bloc<Event, State> {
  static AppString _appString = AppModule.to.getDependency();

  static AppColor _appColor = AppModule.to.getDependency();

  AppBloc appBloc = AppModule.to.getBloc();

  AppColor get color => _appColor;

  AppString get string => _appString;

  Locale get locale => Locale(_appString.languageCode);

  getLanguage() => locale.languageCode;

  setLanguage(String language) {
    _appString.languageCode = language;
  }

  @override
  Future<void> close() {
    appBloc.close();
    return super.close();
  }
}
