import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SingleChildScrollViewDisallowGlow extends StatelessWidget {
  final Widget child;

  final EdgeInsetsGeometry padding;

  /// to implemented parent LayoutBuilder widget
  final bool layoutBuilder;

  /// get boxConstraint from ConstrainedBox, only works if [layoutBuilder] is true
  final Function(BoxConstraints) boxConstraint;

  /// SingleChildScrollView without glow
  const SingleChildScrollViewDisallowGlow({
    Key key,
    this.child,
    this.padding,
    this.layoutBuilder = false,
    this.boxConstraint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return layoutBuilder
        ? LayoutBuilder(builder: (context, constraint) {
            boxConstraint?.call(constraint);
            return _singleScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: child,
                ),
              ),
            );
          })
        : _singleScrollView();
  }

  Widget _singleScrollView({Widget child}) =>
      NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          padding: padding ?? EdgeInsets.all(0),
          child: child ?? this.child,
        ),
      );
}
