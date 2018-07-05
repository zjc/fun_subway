import 'package:flutter/material.dart';
import 'home.dart';
import 'make.dart';
import 'my.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<MainPage> {
  int _tabIndex = 0;

  final navigatorKey = GlobalKey<NavigatorState>();

  List<BottomNavigationBarItem> _navigationViews;

  var appBarTitles = ['首页', '制作', '我'];

  var _body;

  @override
  void initState() {
    super.initState();
    _navigationViews = [
      new BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          title: new Text(appBarTitles[0]),
          backgroundColor: Colors.white),
      new BottomNavigationBarItem(
          icon: const Icon(Icons.edit),
          title: new Text(appBarTitles[1]),
          backgroundColor: Colors.white),
      new BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          title: new Text(appBarTitles[2]),
          backgroundColor: Colors.white)
    ];
  }

  initData() {
    _body = new IndexedStack(
      children: <Widget>[new HomePage(), new MakePage(), new MyPage()],
      index: _tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      navigatorKey: navigatorKey,
      home: new Scaffold(
        body: _body,
        bottomNavigationBar: new BottomNavigationBar(
          items: _navigationViews
              .map((BottomNavigationBarItem navigationView) => navigationView)
              .toList(),
          currentIndex: _tabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
