import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/test_async.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TestFuture extends StatefulWidget {
  const TestFuture({Key? key}) : super(key: key);

  @override
  State<TestFuture> createState() => _TestFutureState();
}

class _TestFutureState extends State<TestFuture> {
  Future<CommonModel> fetchGet() async {
    final response = await http.get(Uri.parse(
        'http://www.devio.org/io/flutter_app/json/test_common_model.json'));
    Utf8Decoder utf8decoder = const Utf8Decoder();
    final result = json.decode(utf8decoder.convert(response.bodyBytes)); // 解码
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CommonModel>(
        future: fetchGet(),
        builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('Input a URL to start');
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(), // 进度条
              );
            case ConnectionState.active:
              return const Text('');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text(
                    '${snapshot.error}',
                    style: const TextStyle(color: Colors.red)
                );
              } else {
                return Column(children: [
                  Text('icon: ${snapshot.data?.icon}'),
                  Text('statusBarColor: ${snapshot.data?.statusBarColor}'),
                  Text('title: ${snapshot.data?.title}'),
                  Text('url: ${snapshot.data?.url}'),
                  Text('hideAppBar: ${snapshot.data?.hideAppBar}'),
                ]);
              }
          }
        });
  }
}
