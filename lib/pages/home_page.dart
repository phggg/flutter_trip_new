import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:http/http.dart' as http;

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
  String showResult = '';
  Future<CommonModel> fetchGet() async {
    final response = await http.get(Uri.parse('http://www.devio.org/io/flutter_app/json/test_common_model.json'));
    final result = json.decode(response.body);
    return CommonModel.fromJson(result);
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
                  height: 1000,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          fetchGet().then((value) => {
                            setState(() => {
                              showResult = '请求结果：\nhideAppBar: ${value.hideAppBar}\nicon: ${value.icon}'
                            })
                          });
                        },
                        child: const Text('点我'),
                      ),
                      Text(showResult)
                    ],
                  ),
                )
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

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel({required this.icon, required this.title, required this.url, required this.statusBarColor, required this.hideAppBar});
  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar']
    );
  }
}