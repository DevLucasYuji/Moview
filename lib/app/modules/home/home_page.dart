import 'package:Moview/app/modules/home/bloc/home_bloc.dart';
import 'package:Moview/app/modules/home/home_module.dart';
import 'package:Moview/app/widgets/animatedBottomNavigationBar/animated_bottom_navigation_bar.dart';
import 'package:Moview/app/widgets/animatedBottomNavigationBar/animated_navigation_item.dart';
import 'package:Moview/app/widgets/app_icon_button.dart';
import 'package:Moview/app/widgets/background_linear.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc = HomeModule.to.bloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimBottomNavigationBar(
        backgroundColor: _bloc.color.background,
        disabledColor: _bloc.color.primaryVariant,
        items: _navItems,
      ),
      body: Stack(
        children: <Widget>[
          BackgroundLinear(),
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (scroll) {
              scroll.disallowGlow();
              return true;
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black,
                          Colors.black45,
                          Colors.black12
                        ],
                      ),
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Image.asset(
                      'assets/images/logo_icon.png',
                    ),
                  ),
                  snap: true,
                  floating: true,
                  expandedHeight: 70,
                  title: ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Text("Séries",
                            style: TextStyle(
                              fontSize: 16.0,
                            )),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Text("Filmes",
                            style: TextStyle(
                              fontSize: 16.0,
                            )),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Text("Minha lista",
                            style: TextStyle(
                              fontSize: 16.0,
                            )),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                    child: Transform.translate(
                  offset: Offset(0, -100),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/pikachu.jpeg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        height: (MediaQuery.of(context).size.height / 100) * 85,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.transparent,
                              Colors.black87,
                            ],
                          ),
                        ),
                        height: (MediaQuery.of(context).size.height / 100) * 85,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 48.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppIconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    child: Text(
                                      "Minha lista",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                  RaisedButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 24.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    color: _bloc.color.primaryVariant,
                                    textColor: Colors.white,
                                    child: Row(
                                      children: [
                                        Icon(FontAwesomeIcons.solidHeart),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text("Favoritar"),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                  AppIconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.infoCircle,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    child: Text(
                                      "Saiba mais",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
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
