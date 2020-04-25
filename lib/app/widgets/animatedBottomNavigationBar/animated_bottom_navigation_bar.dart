import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/app_module.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'animated_bottom_navigation_item.dart';
import 'animated_navigation_item.dart';
import 'bloc/bottom_nav_bloc.dart';

class AnimBottomNavigationBar extends StatefulWidget {
  final List<AnimatedNavigationItem> items;

  final int initialIndex;

  const AnimBottomNavigationBar({
    Key key,
    this.items,
    this.initialIndex = 0,
  })  : assert(items != null),
        assert(initialIndex != null && initialIndex < items.length),
        super(key: key);

  @override
  _AnimBottomNavigationBarState createState() =>
      _AnimBottomNavigationBarState();
}

class _AnimBottomNavigationBarState extends State<AnimBottomNavigationBar> {
  // int _oldIndex;
  int _index;
  BottomNavBloc _blocBottom;
  AppColor appColor = AppModule.to.getDependency();

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _blocBottom = BottomNavBloc();
  }

  @override
  void dispose() {
    _blocBottom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widthItem = MediaQuery.of(context).size.width / widget.items.length;
    var margin = widthItem / 6;
    return Stack(
      children: <Widget>[
        BlocProvider(
          blocs: [
            Bloc((i) => _blocBottom),
          ],
          child: Consumer<BottomNavBloc>(
            builder: (context, bloc) {
              double posX = widthItem * bloc.index;
              return TweenAnimationBuilder(
                duration: Duration(milliseconds: 500),
                tween: Tween(begin: 0, end: posX),
                curve: Curves.fastOutSlowIn,
                builder: (BuildContext context, value, Widget child) {
                  return Transform.translate(
                    offset: Offset(value, -32),
                    child: child,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          appColor.secondaryVariant,
                          appColor.secondary,
                        ]),
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(left: margin, right: margin),
                  width: widthItem - margin * 2,
                  height: widthItem - margin * 2,
                ),
              );
            },
          ),
        ),
        Container(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items.map((item) {
              int itemIndex = widget.items.indexOf(item);
              return AnimatedBottomNavigationItem(
                  navigationItem: item,
                  selectedItem: _index == itemIndex,
                  count: widget.items.length,
                  onTap: () {
                    setState(() {
                      _index = itemIndex;
                    });
                    _blocBottom.setIndex(itemIndex);
                  });
            }).toList(),
          ),
        ),
      ],
    );
  }
}
