import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/app_module.dart';
import 'package:Moview/app/app_routes.dart';
import 'package:Moview/app/bloc/app_bloc.dart';
import 'package:Moview/app/bloc/app_state.dart';
import 'package:Moview/app/modules/home/home_module.dart';
import 'package:Moview/app/modules/login/login_module.dart';
import 'package:Moview/app/modules/splash/splash_module.dart';
import 'package:Moview/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppColor color = AppModule.to.getDependency();
    return BlocProvider(
      create: ((context) => AppModule.to.bloc<AppBloc>()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
              localizationsDelegates: [
                AppStringDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: [
                Locale('en', 'US'),
                Locale('pt', 'BR'),
              ],
              title: 'Flutter aaa',
              themeMode: ThemeMode.system,
              theme: ThemeData(
                primaryColor: color.primary,
                secondaryHeaderColor: color.secondary,
              ),
              initialRoute: Routes.splash,
              routes: {
                Routes.splash: (context) => SplashModule(),
                Routes.home: (context) => HomeModule(),
                Routes.login: (context) => LoginModule()
              });
        },
      ),
    );
  }
}
