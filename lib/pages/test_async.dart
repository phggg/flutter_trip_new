import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TestAsync extends StatefulWidget {
  const TestAsync({Key? key}) : super(key: key);

  @override
  State<TestAsync> createState() => _TestAsyncState();
}

class _TestAsyncState extends State<TestAsync> {

  String showResult = '';
  Future<CommonModel> fetchGet() async {
    final response = await http.get(Uri.parse('http://www.devio.org/io/flutter_app/json/test_common_model.json'));
    final result = json.decode(response.body);
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            child: const Text('点我21323'),
          ),
          Text(showResult)
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