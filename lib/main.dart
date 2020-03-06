import 'package:flutter/material.dart';

import 'MainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audio Map',
      initialRoute: '/',
      routes: {
        '/':(context) => MainScreen(),
      },
    );
  }
}