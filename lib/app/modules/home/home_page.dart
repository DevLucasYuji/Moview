import 'package:Moview/app/bloc/app_event.dart';
import 'package:Moview/app/modules/home/bloc/home_bloc.dart';
import 'package:Moview/app/modules/home/bloc/home_state.dart';
import 'package:Moview/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc = HomeModule.to.bloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(bloc.translator.hello),
          ),
          body: Container(
            color: bloc.color.primary,
            child: Center(
              child: FlatButton(
                child: Text(
                  "Trocar",
                  style: TextStyle(color: bloc.color.secondary),
                ),
                onPressed: () {
                  _onButtonPressed();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _onButtonPressed() {
    var locale = Locale(bloc.getLanguage() == 'pt' ? 'en' : 'pt');
    bloc.appBloc.add(AppLanguageEvent(locale));
    bloc.appBloc.add(AppColorEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
