import 'package:flutter/material.dart';

class AnimatedNavigationItem {
  final Text text;
  final IconData icon;
  final Color color;

  AnimatedNavigationItem({
    this.text,
    this.icon,
    this.color,
  })  : assert(color != null),
        assert(text != null),
        assert(icon != null);
}
