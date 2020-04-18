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

  bool _obscureText = true;
  bool _initialAnimation = true;
  Alignment _alignment = Alignment.center;
  double _opacityLogo = 0;

  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bloc.color.secondary,
      body: Padding(
        padding: const EdgeInsets.only(top: 72),
        child: _initialAnimation ? _animation() : _body(),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Widget _body() {
    Future.delayed(Duration(milliseconds: 100)).then(
      (value) => setState(() => _opacityLogo = 1),
    );
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _logoIcon(),
              _animatedOpacity(
                _logoName(),
                padding: const EdgeInsets.only(top: 6.0),
              ),
              _animatedOpacity(_formLogin())
            ],
          ),
        ),
      ),
    );
  }

  _animation() {
    Future.delayed(Duration(microseconds: 100)).then(
      (_) => setState(() => _alignment = Alignment.topCenter),
    );
    return AnimatedAlign(
      duration: Duration(milliseconds: 850),
      curve: Curves.easeInOutBack,
      alignment: _alignment,
      onEnd: () => setState(() {
        if (_alignment == Alignment.topCenter) _initialAnimation = false;
      }),
      child: Hero(
        tag: 'hero',
        child: _logoIcon(),
      ),
    );
  }

  Widget _logoIcon() {
    return Image.asset(
      'assets/images/logo_icon.png',
      height: 120,
    );
  }

  Widget _logoName() {
    return Image.asset(
      'assets/images/logo_text.png',
      height: 35,
    );
  }

  Widget _animatedOpacity(Widget child, {EdgeInsetsGeometry padding}) {
    return AnimatedOpacity(
      opacity: _opacityLogo,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: padding ?? EdgeInsets.all(0),
        child: child,
      ),
    );
  }

  Widget _formLogin() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          _fieldText(
              hintText: "Login",
              inputType: TextInputType.emailAddress,
              icon: Icons.account_circle),
          _fieldText(
            hintText: "Senha",
            inputType: TextInputType.visiblePassword,
            obscureText: _obscureText,
            padding: EdgeInsets.only(top: 24),
            icon: Icons.lock,
          )
        ],
      ),
    );
  }

  _fieldText({
    String hintText,
    TextInputType inputType,
    bool obscureText,
    EdgeInsetsGeometry padding,
    IconData icon,
  }) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: TextFormField(
        obscureText: obscureText ?? false,
        keyboardType: inputType,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 20.0,
          decoration: TextDecoration.none,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          filled: true,
          enabled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          suffixStyle: TextStyle(color: Colors.red),
          suffixIcon: obscureText != null
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                  ),
                  highlightColor: Colors.transparent,
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                )
              : null,
          hintText: hintText,
          contentPadding: EdgeInsets.only(top: 16, bottom: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          hintStyle: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
          fillColor: _bloc.color.primary,
        ),
      ),
    );
  }
}
