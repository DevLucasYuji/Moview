import 'package:Moview/app/modules/login/bloc/login_bloc.dart';
import 'package:Moview/app/modules/login/login_module.dart';
import 'package:Moview/app/widgets/background_linear.dart';
import 'package:Moview/app/widgets/single_child_scrollview_disallow_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Stack(
        children: [
          BackgroundLinear(
            beginColor: _bloc.color.secondaryVariant,
            endColor: _bloc.color.secondary,
            begin: Alignment.centerLeft,
          ),
          _initialAnimation ? _animation() : _body(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Widget _body() {
    _setOpacity();

    return SingleChildScrollViewDisallowGlow(
      layoutBuilder: true,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _logoIcon(),
                  _animatedOpacity(
                    child: _logoName(),
                    padding: const EdgeInsets.only(top: 6.0),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _animatedOpacity(
                child: _formLogin(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _animation() {
    Future.delayed(Duration(microseconds: 100)).then(
      (_) => setState(() => _alignment = Alignment.topCenter),
    );
    bool isTopCenter = _alignment == Alignment.topCenter;

    return AnimatedAlign(
      duration: Duration(milliseconds: 850),
      curve: Curves.easeInOutBack,
      alignment: _alignment,
      onEnd: () =>
          setState(() => isTopCenter ? _initialAnimation = false : null),
      child: FractionallySizedBox(
        heightFactor: 0.47,
        child: Hero(
          tag: "logoIcon",
          child: _logoIcon(),
        ),
      ),
    );
  }

  Widget _logoIcon() {
    return Image.asset(
      'assets/images/logo_icon.png',
      width: 90,
      height: 120,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _logoName() {
    return Image.asset(
      'assets/images/logo_text.png',
      height: 35,
    );
  }

  Widget _animatedOpacity({Widget child, EdgeInsetsGeometry padding}) {
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
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
          suffixStyle: TextStyle(color: Colors.red),
          suffixIcon: obscureText != null
              ? IconButton(
                  icon: FaIcon(
                    obscureText
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: Colors.grey[500],
                    size: 20,
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
            color: Colors.grey[500],
            decoration: TextDecoration.none,
          ),
          fillColor: _bloc.color.input,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _bloc.color.primary),
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: _bloc.color.input),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  _setOpacity() {
    Future.delayed(Duration(milliseconds: 100)).then(
      (value) => setState(() => _opacityLogo = 1),
    );
  }
}
