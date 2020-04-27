import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/app_module.dart';
import 'package:Moview/app/app_routes.dart';
import 'package:Moview/app/bloc/app_bloc.dart';
import 'package:Moview/app/bloc/app_state.dart';
import 'package:Moview/app/modules/home_control/home_control_module.dart';
import 'package:Moview/app/modules/login/login_module.dart';
import 'package:Moview/app/modules/splash/splash_module.dart';
import 'package:Moview/generated/l10n.dart';
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
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: S.delegate.supportedLocales,
              title: 'Flutter aaa',
              themeMode: ThemeMode.system,
              theme: ThemeData(
                primaryColor: color.primary,
                secondaryHeaderColor: color.secondary,
              ),
              initialRoute: Routes.splash,
              onGenerateRoute: (settings) {
                var module;
                switch (settings.name) {
                  case Routes.homeControl:
                    module = HomeControlModule();
                    break;
                }

                if (module != null) {
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => module,
                    transitionsBuilder: (_, anim, __, child) {
                      return FadeTransition(opacity: anim, child: child);
                    },
                  );
                }

                return null;
              },
              routes: {
                Routes.splash: (context) => SplashModule(),
                Routes.login: (context) => LoginModule(),
                Routes.homeControl: (context) => HomeControlModule()
              });
        },
      ),
    );
  }
}
