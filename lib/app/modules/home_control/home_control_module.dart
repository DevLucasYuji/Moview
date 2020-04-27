import 'package:Moview/app/modules/home_control/bloc/home_control_bloc.dart';
import 'package:Moview/app/modules/home_control/home_control_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class HomeControlModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeControlBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomeControlPage();

  static Inject get to => Inject<HomeControlModule>.of();
}
