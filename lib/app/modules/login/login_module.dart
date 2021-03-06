import 'package:Moview/app/modules/login/bloc/login_bloc.dart';
import 'package:Moview/app/repositories/login_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:Moview/app/modules/login/login_page.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => LoginBloc(i.getDependency<LoginRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => LoginRepository()),
      ];

  @override
  Widget get view => LoginPage();

  static Inject get to => Inject<LoginModule>.of();
}
