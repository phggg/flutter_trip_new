import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';
import 'package:flutter_trip/pages/user_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    _onTap (index) {
      setState(() {
        _controller.jumpToPage(index);
        _currentIndex = index;
      });
    }

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onTap,
        items: choices.map((item) => BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.label
        )).toList(),
      ),
    );
  }
}

class Choice {
  final String label;
  final IconData icon;
  const Choice({required this.label, required this.icon});
}

const List<Choice> choices = [
  Choice(label: '首页', icon: Icons.home),
  Choice(label: '搜索', icon: Icons.search),
  Choice(label: '旅拍', icon: Icons.camera_alt),
  Choice(label: '我的', icon: Icons.account_circle),
];