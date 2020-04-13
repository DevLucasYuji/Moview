import 'package:Moview/app/modules/splash/bloc/splash_bloc.dart';
import 'package:Moview/app/modules/splash/splash_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class SplashModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SplashBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => SplashPage();

  static Inject get to => Inject<SplashModule>.of();
}
