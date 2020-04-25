import 'package:Moview/app/widgets/animatedBottomNavigationBar/animated_navigation_item.dart';
import 'package:flutter/material.dart';

class AnimatedBottomNavigationItem extends StatefulWidget {
  final AnimatedNavigationItem navigationItem;
  final bool selectedItem;
  final Function onTap;
  final int count;

  AnimatedBottomNavigationItem({
    Key key,
    this.navigationItem,
    this.selectedItem,
    this.onTap,
    this.count,
  })  : assert(navigationItem != null),
        assert(count != null),
        super(key: key);

  @override
  _AnimatedBottomNavigationItemState createState() =>
      _AnimatedBottomNavigationItemState();
}

class _AnimatedBottomNavigationItemState
    extends State<AnimatedBottomNavigationItem> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / widget.count;

    return InkWell(
      onTap: !widget.selectedItem ? widget.onTap : null,
      customBorder: CircleBorder(),
      child: Container(
        width: width,
        child: Transform.translate(
          offset: Offset(0, widget.selectedItem ? -15 : 0),
          child: AnimatedAlign(
            alignment:
                widget.selectedItem ? Alignment.topCenter : Alignment.center,
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOutQuint,
            child: Icon(
              widget.navigationItem.icon,
              color: widget.selectedItem
                  ? widget.navigationItem.color
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
