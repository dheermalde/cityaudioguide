import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  bool _searching;
  String _searchTerm;
  var _placesPredictions;

  @override
  void initState() {
    super.initState();
    _searching = false;
  }

  void _textFieldChange(String value) {
    if (value != '') {
      setState(() {
        _searching = true;
        _searchTerm = value.replaceAll(RegExp(' +'), '+');
      });
    } else {
      setState(() {
        _searching = false;
        _searchTerm = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidgetBuilder(context, 'Search Screen'),
      body: _buildSearchWidget(context),
    );
  }

  Widget _appBarWidgetBuilder(BuildContext context, String titleName) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text('$titleName'),
    );
  }

  Widget _buildSearchWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        _backgroundWidget(context),
        Card(
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: _searchWidgetList(),
          ),
        ),
      ],
    );
  }

  Widget _backgroundWidget(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'Map Goes Here',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<Widget> _searchWidgetList() {
    var builder = <Widget>[
      new TextField(
        onChanged: _textFieldChange,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          suffixIcon: Icon(Icons.search),
        )
      ),
    ];
    if (_searching) {
      builder.add(
        new Flexible(
          child: new ListView.separated(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index){
              return new Container(
                child: new Text('$_searchTerm'),
              );
            },
            separatorBuilder: (BuildContext context, int index){
              return new Divider();
            },
          ),
        )
      );
    }
    return builder;
  }
}