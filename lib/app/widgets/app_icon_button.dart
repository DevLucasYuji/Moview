import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final bool vertical;
  final Icon icon;
  final Widget child;
  final Function onPressed;

  const AppIconButton({
    Key key,
    this.vertical,
    this.icon,
    this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          icon,
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: child,
          ),
        ],
      ),
    );
  }
}
