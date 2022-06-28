import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/test_grid.dart';
import 'package:flutter_trip/pages/test_list.dart';
import 'package:flutter_trip/pages/test_list_more.dart';
import 'package:flutter_trip/pages/test_pull_refresh.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: TestGrid(),
        child: TestPullRefresh(),
      ),
    );
  }
}
