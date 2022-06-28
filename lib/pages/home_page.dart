import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/pages/shared_preferences.dart';
import 'package:flutter_trip/pages/test_async.dart';
import 'package:flutter_trip/pages/test_future.dart';


const int appbarScrollOffset = 100;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _imageUrls = [
    'https://img.win3000.com/m00/5d/91/229df81eee87bc842739e91efdc5440a.jpg',
    'https://img.win3000.com/m00/7d/6a/1ea96c2e771aa3a51937df1de3988d5d.jpg',
    'https://img.win3000.com/m00/2b/38/9af24eb2152e2f5dc813d92755ae83d0.png'
  ];
  double appBarAlpha = 0;
  String resultString = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void _onScroll(offset){
    double alpha = offset / appbarScrollOffset;
    if(alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(model);
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener( // flutter中想要监听滚动，必须要有这个类
            onNotification: (scrollNotification) {
              if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                // scrollNotification.depth == 0 ,只监听第0个元素的滚动
                _onScroll(scrollNotification.metrics.pixels);
              }
              return true;
            },
            child: ListView( // ListView默认为了兼容部分机型，在顶部加了一块间距，可以通过MediaQuery.removePadding删除, 也可以将padding设置为0
              padding: const EdgeInsets.only(top: 0),
              children: [
                SizedBox(
                  height: 160,
                  child: Swiper(
                    itemBuilder: (BuildContext context,int index){
                      return Image.network(_imageUrls[index],fit: BoxFit.cover,);
                    },
                    itemCount: _imageUrls.length,
                    autoplay: true,
                    pagination: const SwiperPagination(),
                    // control: const SwiperControl(),
                    // viewportFraction: 0.8,
                    // scale: 0.9,
                  ),
                ),
                SizedBox(
                  height: 800,
                  child: Text('$resultString resultString'),
                )
                // const TestAsync(),
                // const TestFuture(),
                // SharedPreferencesComponent()
              ],
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
