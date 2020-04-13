import 'dart:async';
import 'package:Moview/app/app_color.dart';
import 'package:Moview/app_string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => InitialAppState();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppColorEvent) {
      AppColor().switchMode();
      yield AppColorState();
    }

    if (event is AppLanguageEvent) {
      AppString.load(event.locale);
      yield AppLanguageState();
    }
  }
}
