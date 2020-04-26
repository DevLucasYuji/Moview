import 'package:Moview/app/app_routes.dart';
import 'package:Moview/app/modules/splash/bloc/splash_bloc.dart';
import 'package:Moview/app/modules/splash/bloc/splash_event.dart';
import 'package:Moview/app/modules/splash/bloc/splash_state.dart';
import 'package:Moview/app/modules/splash/splash_module.dart';
import 'package:Moview/app/widgets/background_linear.dart';
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundLinear(),
        Container(
          child: Center(
            child: BlocBuilder<SplashBloc, SplashState>(
              bloc: _bloc,
              builder: (BuildContext context, state) {
                if (state is SplashAnimationState) {
                  return _animationScale(context);
                }

                if (state is FinishSplashState) {
                  return Hero(
                    tag: "logoIcon",
                    child: _animationTransform(context, state.isReverse, () {
                      if (!state.isReverse) {
                        Future.delayed(Duration(milliseconds: 250)).then((_) {
                          _bloc.add(
                            FinishSplashEvent(isReverse: !state.isReverse),
                          );
                        });
                      } else {
                        final route = state.isAuth ? Routes.home : Routes.login;
                        Navigator.pushReplacementNamed(context, route);
                      }
                    }),
                  );
                }
                return _logoWidget(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  TweenAnimationBuilder<double> _animationScale(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0.5),
      curve: Curves.easeInBack,
      duration: Duration(seconds: 1),
      onEnd: () => _bloc.add(FinishSplashEvent(isReverse: false)),
      builder: (_, value, child) {
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
      width: 175,
    );
  }

  Widget _logoNameWidget() {
    return Image.asset(
      'assets/images/logo_text.png',
      width: 230,
    );
  }

  Widget _animationTransform(context, bool isReverse, Function onEnd) {
    double beginName = -375;
    double endName = 55;
    double beginLogo = 0;
    double endLogo = -125;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _animationTranslate(
          isReverse: isReverse,
          begin: beginName,
          end: endName,
          child: _logoNameWidget(),
          onEnd: onEnd,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              color: _bloc.color.background,
              width: (MediaQuery.of(context).size.width / 2) - endName - 25,
            ),
          ),
        ),
        _animationTranslate(
          isReverse: isReverse,
          begin: beginLogo,
          end: endLogo,
          child: _transformScale(0.5, _logoWidget(context)),
        )
      ],
    );
  }

  TweenAnimationBuilder<double> _animationTranslate({
    Widget child,
    double begin,
    double end,
    Function onEnd,
    bool isReverse,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: isReverse ? end : begin,
        end: isReverse ? begin : end,
      ),
      duration: Duration(milliseconds: isReverse ? 1250 : 2000),
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
      size.height / 1.95,
    );
    path.lineTo(
      size.width,
      size.height / 2.05,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper size) => false;
}
