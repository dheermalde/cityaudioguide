import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'mapscreen.dart';
import 'searchscreen.dart';
import 'test.dart';
import 'nearbyscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/':(context) => HomeScreen(),
        '/MapScreen':(context) => MapScreen(),
        '/SearchScreen':(context) => SearchScreen(),
        '/TestScreen':(context) => TestScreen(),
        '/NearbyScreen':(context) => NearbyScreen(),
      },
    );
  }
}
