import 'package:Moview/app/widgets/animatedBottomNavigationBar/animated_navigation_item.dart';
import 'package:flutter/material.dart';

class AnimBottomNavItem extends StatefulWidget {
  final AnimatedNavigationItem navigationItem;
  final bool selectedItem;
  final Function onTap;
  final int count;
  final Color disabledColor;

  AnimBottomNavItem({
    Key key,
    this.navigationItem,
    this.selectedItem,
    this.disabledColor,
    this.onTap,
    this.count,
  })  : assert(navigationItem != null),
        assert(count != null),
        super(key: key);

  @override
  _AnimBottomNavItemState createState() => _AnimBottomNavItemState();
}

class _AnimBottomNavItemState extends State<AnimBottomNavItem> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / widget.count;

    return InkWell(
      onTap: !widget.selectedItem ? widget.onTap : null,
      customBorder: CircleBorder(),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: width,
              child: Transform.translate(
                offset: Offset(0, widget.selectedItem ? -15 : 0),
                child: AnimatedAlign(
                  alignment: widget.selectedItem
                      ? Alignment.topCenter
                      : Alignment.center,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.elasticInOut,
                  child: Icon(
                    widget.navigationItem.icon,
                    color: widget.selectedItem
                        ? widget.navigationItem.color
                        : widget.disabledColor,
                  ),
                ),
              ),
            ),
          ),
          widget.selectedItem
              ? TweenAnimationBuilder(
                  builder: (BuildContext context, value, Widget child) {
                    return Transform.translate(
                      offset: Offset(0, value),
                      child: child,
                    );
                  },
                  curve: Curves.easeInOutBack,
                  duration: Duration(milliseconds: 250),
                  tween: Tween(begin: 0.0, end: -20.0),
                  child: widget.navigationItem.text,
                )
              : Container()
        ],
      ),
    );
  }
}
