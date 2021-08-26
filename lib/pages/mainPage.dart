import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magento2_app/pages/cartPage.dart';
import 'package:magento2_app/pages/homePage.dart';
import 'package:magento2_app/pages/categoryPage.dart';
import 'package:magento2_app/pages/keep_alive_wrapper.dart';
import 'package:magento2_app/pages/morePage.dart';
import 'package:magento2_app/pages/profilePage.dart';

import 'cartPageV2.dart';

class MainPage extends StatefulWidget {
  static const String routeName = "main";
  final String pageTitle = "";
  DateTime? currentBackPressTime;
  final GlobalKey _bottomBarKey = GlobalKey();
  PageController pageViewCtl = PageController();
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _loadWidget(_currentIndex),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                //physics: NeverScrollableScrollPhysics(),
                controller: newPageController(),
                children: contentPageView(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedLabelStyle: TextStyle(fontSize: 10),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Category'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            title: Text('More'),
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
  List<Widget> contentPageView() {
    return <Widget>[
      KeepAliveWrapper(child: HomePage()),
      KeepAliveWrapper(
          child: CategoryPage(
            category: null,
          )),
      CartPageV2(),
      KeepAliveWrapper(child: ProfilePage()),
      KeepAliveWrapper(child: MorePage())
    ];
  }
  PageController newPageController() {
    widget.pageViewCtl = PageController();
    return widget.pageViewCtl;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.pageViewCtl.jumpToPage(index);
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (widget.currentBackPressTime == null || now.difference(widget.currentBackPressTime!) > Duration(seconds: 2)) {
      widget.currentBackPressTime = now;
      final snackBar = SnackBar(content: Text('Back....'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
