import 'package:Moview/app/modules/login/bloc/login_bloc.dart';
import 'package:Moview/app/modules/login/login_module.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _bloc = LoginModule.to.getBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        color: _bloc.color.secondary,
        child: Column(
          children: [
            Hero(
              tag: 'hero',
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
