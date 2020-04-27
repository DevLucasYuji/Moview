import 'package:Moview/app/modules/login/bloc/login_bloc.dart';
import 'package:Moview/app/modules/login/bloc/login_event.dart';
import 'package:Moview/app/modules/login/bloc/login_state.dart';
import 'package:Moview/app/modules/login/login_module.dart';
import 'package:Moview/app/utils/regex_util.dart';
import 'package:Moview/app/widgets/app_button.dart';
import 'package:Moview/app/widgets/app_text_field.dart';
import 'package:Moview/app/widgets/background_linear.dart';
import 'package:Moview/app/widgets/single_child_scrollview_disallow_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_routes.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _bloc = LoginModule.to.getBloc();

  GlobalKey _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Alignment _alignment = Alignment.center;
  double _opacityLogo = 0;
  bool _obscureText = true;
  bool _initialAnimation = true;
  bool _isLoading;

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _body() {
    return SingleChildScrollViewDisallowGlow(
      layoutBuilder: true,
      child: Form(
        key: _formKey,
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _bloc,
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: _finishAnimation(
                  state: state,
                  toUp: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _logoIcon(),
                      _animatedOpacity(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: _logoName(),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: _finishAnimation(
                  state: state,
                  child: _animatedOpacity(
                    child: _formLogin(state),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> _finishAnimation({
    Widget child,
    LoginState state,
    bool toUp = false,
  }) {
    var end = 0.0;

    if (state is SuccessLoginState) {
      double halfHeight = MediaQuery.of(context).size.height / 2;
      end = toUp ? -halfHeight : halfHeight;
    }

    return TweenAnimationBuilder(
      builder: (BuildContext context, value, Widget child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
      onEnd: () {
        if (state is SuccessLoginState) {
          _showHome(context);
        }
      },
      curve: Curves.easeInOutBack,
      tween: Tween(
        begin: 0.0,
        end: end,
      ),
      duration: Duration(milliseconds: 1250),
      child: child,
    );
  }

  _animation() {
    Future.microtask(() => setState(() => _alignment = Alignment.topCenter));
    bool isTopCenter = _alignment == Alignment.topCenter;

    return AnimatedAlign(
      duration: Duration(milliseconds: 650),
      curve: Curves.linearToEaseOut,
      alignment: _alignment,
      onEnd: () {
        setState(() => isTopCenter ? _initialAnimation = false : null);
      },
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Transform.translate(
          offset: Offset(0, -20.5),
          child: Hero(
            tag: "logoIcon",
            child: _logoIcon(),
          ),
        ),
      ),
    );
  }

  Widget _logoIcon() {
    return Image.asset(
      'assets/images/logo_icon.png',
      width: 85,
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
    Future.microtask(() => setState(() => _opacityLogo = 1));

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

  Widget _formLogin(LoginState state) {
    _isLoading = state is LoadingLoginState;

    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppTextField(
            hintText: "Login",
            inputType: TextInputType.emailAddress,
            icon: Icons.account_circle,
            controller: _emailController,
            validator: (String email) {
              if (email.isEmpty) {
                return _bloc.translator.emptyField;
              }

              if (!RegexUtils.validEmail(email)) {
                return _bloc.translator.emailInvalid;
              }

              return null;
            },
          ),
          AppTextField(
            hintText: _bloc.translator.password,
            inputType: TextInputType.visiblePassword,
            obscureText: _obscureText,
            padding: EdgeInsets.only(top: 24),
            icon: Icons.lock,
            controller: _passwordController,
            onSuffixPressed: () => setState(() => _obscureText = !_obscureText),
          ),
          (state is ErrorLoginState)
              ? Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    state.message,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButton(
                  onPressed: () {},
                  child: Text(
                    _bloc.translator.register,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  ),
                  highlightedBorderColor: Colors.transparent,
                ),
                AppButton(
                  text: _bloc.translator.enter,
                  isLoading: _isLoading,
                  onPressed: () {
                    final FormState form = _formKey.currentState;
                    if (form.validate()) {
                      _bloc.add(
                        FetchLoginEvent(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showHome(context) {
    Navigator.of(context).pushReplacementNamed(Routes.homeControl);
  }
  // Navigator.pushReplacementNamed(context, Routes.home);
}
