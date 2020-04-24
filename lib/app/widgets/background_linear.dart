import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/app_module.dart';
import 'package:flutter/material.dart';

class BackgroundLinear extends StatelessWidget {
  final AppColor _appColor = AppModule.to.getDependency();
  final Color beginColor;
  final Color endColor;
  final Alignment begin;
  final Alignment end;
  final Widget child;

  BackgroundLinear({
    Key key,
    this.beginColor,
    this.endColor,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.bottomRight,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            beginColor ?? _appColor.secondaryVariant,
            endColor ?? _appColor.secondary,
          ],
          begin: begin,
          end: end,
          stops: [0.35, 1],
        ),
      ),
      child: child ?? Container(),
    );
  }
}
