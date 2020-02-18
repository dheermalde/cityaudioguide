import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Padding (
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Text('Pages to visit'),
              _MapScreenButton(context),
              _SearchScreenButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _MapScreenButton(BuildContext context){
    return RaisedButton(
      child: Text('MapScreen'),
      onPressed: () {Navigator.pushNamed(context, '/MapScreen');},
    );
  }

  Widget _SearchScreenButton(BuildContext context){
    return RaisedButton(
      child: Text(
        'Search Widget (WIP)',
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {Navigator.pushNamed(context, '/SearchScreen');},
    );
  }
}