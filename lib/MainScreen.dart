import 'package:flutter/material.dart';

import 'MapWidget.dart';
import 'SearchBarWidget.dart';
import 'Logic.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  Logic _logic = new Logic();

  void _callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          MapWidget(_logic, this._callback),
          SearchBarWidget(_logic, this._callback),
        ],
      ),
    );
  }
}