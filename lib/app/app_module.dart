import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/bloc/app_bloc.dart';
import 'package:Moview/app/helpers/firebase_helper.dart';
import 'package:Moview/generated/l10n.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:Moview/app/app_widget.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => S()),
        Dependency((i) => AppColor()),
        Dependency((i) => FirebaseHelper())
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
