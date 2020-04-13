import 'package:flutter/cupertino.dart';

class AnimationHelper {
  AnimationController _animationController;
  TickerProvider _ticker;
  Duration _duration;

  void build({
    vsync: TickerProvider,
    duration: Duration,
  }) {
    _animationController = AnimationController(
      vsync: vsync ?? _ticker,
      duration: duration ?? _duration,
    );
  }
}
