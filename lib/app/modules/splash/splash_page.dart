import 'package:Moview/app/app_routes.dart';
import 'package:Moview/app/modules/splash/bloc/splash_bloc.dart';
import 'package:Moview/app/modules/splash/bloc/splash_event.dart';
import 'package:Moview/app/modules/splash/bloc/splash_state.dart';
import 'package:Moview/app/modules/splash/splash_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc _bloc = SplashModule.to.getBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(InitialEvent());
  }

  double _scaleValue;
  double begin;
  double end;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bloc.color.secondary,
      child: Center(
        child: BlocBuilder<SplashBloc, SplashState>(
          bloc: _bloc,
          builder: (BuildContext context, state) {
            if (state is SplashAnimationState) {
              return _animationScale(context);
            }

            if (state is SplashFinishState) {
              return Hero(
                tag: 'hero',
                child: _animationTransform(context, () {
                  final route = state.isAuth ? Routes.login : Routes.login;
                  Navigator.pushNamed(context, route);
                }),
              );
            }

            return _logoWidget(context);
          },
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> _animationScale(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0.4),
      curve: Curves.easeInBack,
      duration: Duration(seconds: 1),
      onEnd: () => _bloc.add(FinishEvent()),
      builder: (_, value, child) {
        _scaleValue = value;
        return _transformScale(value, child);
      },
      child: _logoWidget(context),
    );
  }

  Transform _transformScale(double value, Widget child) =>
      Transform.scale(scale: value, child: child);

  Widget _logoWidget(BuildContext context) {
    return Image.asset(
      'assets/images/logo_icon.png',
      fit: BoxFit.fitWidth,
      width: 225,
    );
  }

  Widget _logoNameWidget() {
    return Image.asset(
      'assets/images/logo_text.png',
      width: 230,
    );
  }

  Widget _animationTransform(BuildContext context, Function onEnd) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _animationTranslate(
          begin: -375,
          end: 60,
          child: _logoNameWidget(),
          onEnd: onEnd,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              height: 225,
              color: _bloc.color.secondary,
              width: 115,
            ),
          ),
        ),
        _animationTranslate(
          begin: 0,
          end: -125,
          child: _transformScale(_scaleValue, _logoWidget(context)),
        )
      ],
    );
  }

  TweenAnimationBuilder<double> _animationTranslate({
    Widget child,
    double begin,
    double end,
    Function onEnd,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: end),
      duration: Duration(seconds: 2),
      curve: Curves.easeInOutQuint,
      onEnd: onEnd,
      builder: (_, value, child) => Transform.translate(
        offset: Offset(value, 0),
        child: child,
      ),
      child: child,
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(
      size.width,
      size.height / 2,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper size) => false;
}
