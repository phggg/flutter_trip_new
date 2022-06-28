import 'package:flutter/material.dart';

const CITY_NAMES = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];

class TestList extends StatefulWidget {
  const TestList({Key? key}) : super(key: key);

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {

  @override
  Widget build(BuildContext context) {
    return Scrollbar( // 添加滚动条
        child: ListView(
          // scrollDirection: Axis.horizontal, // 设置滚动方向
          children: _buildList(),
        )
    );
  }

  Widget _item(String city) {
    return Container(
      height: 160,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }
}
