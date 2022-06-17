import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesComponent extends StatefulWidget {
  const SharedPreferencesComponent({Key? key}) : super(key: key);

  @override
  State<SharedPreferencesComponent> createState() => _SharedPreferencesComponentState();
}

class _SharedPreferencesComponentState extends State<SharedPreferencesComponent> {
  String countString = '2';
  String localCount = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: _incrementCounter, child: const Text('Increment Count')),
        ElevatedButton(onPressed: _getCounter, child: const Text('get Count')),
        Text(countString, style: const TextStyle(fontSize: 20)),
        Text(localCount, style: const TextStyle(fontSize: 20))
      ],
    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countString = countString + '1';
    });
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', counter);
  }

  _getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = prefs.getInt('counter').toString();
    });
  }
}
