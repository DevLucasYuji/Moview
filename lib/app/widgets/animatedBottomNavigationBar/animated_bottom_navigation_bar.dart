import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/app_module.dart';
import 'package:flutter/material.dart';

import 'animated_bottom_navigation_item.dart';
import 'animated_navigation_item.dart';

class AnimBottomNavigationBar extends StatefulWidget {
  final List<AnimatedNavigationItem> items;
  final Color backgroundColor;
  final int initialIndex;
  final Color disabledColor;
  final Function(int) onItemPressed;

  const AnimBottomNavigationBar({
    Key key,
    this.items,
    this.initialIndex = 0,
    this.backgroundColor,
    this.disabledColor,
    this.onItemPressed,
  })  : assert(items != null),
        assert(initialIndex != null && initialIndex < items.length),
        super(key: key);

  @override
  _AnimBottomNavigationBarState createState() =>
      _AnimBottomNavigationBarState();
}

class _AnimBottomNavigationBarState extends State<AnimBottomNavigationBar> {
  int _index = 1;
  AppColor appColor = AppModule.to.getDependency();

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    var widthItem = MediaQuery.of(context).size.width / widget.items.length;
    var margin = widthItem / 6;
    double posX = widthItem * _index;

    return Stack(
      children: <Widget>[
        TweenAnimationBuilder(
          duration: Duration(milliseconds: 350),
          tween: Tween(begin: 0.0, end: posX),
          curve: Curves.fastOutSlowIn,
          builder: (BuildContext context, value, Widget child) {
            return Transform.translate(
              offset: Offset(value, -32.0),
              child: child,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: widget.items[_index].color,
              ),
            ),
            margin: EdgeInsets.only(left: margin, right: margin),
            width: widthItem - margin * 2,
            height: widthItem - margin * 2,
          ),
        ),
        Container(
          height: 68,
          color: widget.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items.map((item) {
              int itemIndex = widget.items.indexOf(item);
              return AnimBottomNavItem(
                  navigationItem: item,
                  selectedItem: _index == itemIndex,
                  count: widget.items.length,
                  disabledColor: widget.disabledColor,
                  onTap: () {
                    setState(() {
                      _index = itemIndex;
                    });
                    widget.onItemPressed(itemIndex);
                  });
            }).toList(),
          ),
        ),
      ],
    );
  }
}
