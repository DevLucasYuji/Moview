import 'package:Moview/app/modules/home/home_module.dart';
import 'package:Moview/app/modules/home_control/bloc/home_control_bloc.dart';
import 'package:Moview/app/modules/home_control/home_control_module.dart';
import 'package:Moview/app/widgets/animatedBottomNavigationBar/animated_bottom_navigation_bar.dart';
import 'package:Moview/app/widgets/animatedBottomNavigationBar/animated_navigation_item.dart';
import 'package:Moview/app/widgets/background_linear.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeControlPage extends StatefulWidget {
  final String title;
  const HomeControlPage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomeControlPageState createState() => _HomeControlPageState();
}

class _HomeControlPageState extends State<HomeControlPage> {
  HomeControlBloc _bloc = HomeControlModule.to.bloc();
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimBottomNavigationBar(
        backgroundColor: _bloc.color.background,
        disabledColor: _bloc.color.primaryVariant,
        items: _navItems,
        onItemPressed: (index) => _pageController.jumpToPage(index),
      ),
      body: Stack(
        children: <Widget>[
          BackgroundLinear(),
          PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            allowImplicitScrolling: true,
            children: [
              HomeModule(),
              Container(),
              Container(),
              Container(),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    _pageController.dispose();
    super.dispose();
  }

  List<AnimatedNavigationItem> get _navItems {
    return [
      AnimatedNavigationItem(
        color: Colors.grey,
        icon: FontAwesomeIcons.home,
        text: Text(
          "Home",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
      AnimatedNavigationItem(
        color: Colors.blueAccent,
        icon: FontAwesomeIcons.search,
        text: Text(
          "Search",
          style:
              TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        ),
      ),
      AnimatedNavigationItem(
        color: Colors.red,
        icon: FontAwesomeIcons.heart,
        text: Text(
          "Favorite",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      AnimatedNavigationItem(
        color: Colors.green,
        icon: FontAwesomeIcons.user,
        text: Text(
          "Profile",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }
}
