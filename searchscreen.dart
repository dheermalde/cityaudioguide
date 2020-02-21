import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'QueryAutocompletePredictions.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  bool _searching;
  String _searchTerm;
  String _APIKEY = "AIzaSyCLHmHIYCCIxF6l9YTzmzbgAe8vqlSK4Pw";
  var _parsedJson;
  var _placesPredictions;
  Future<QueryAutocompletePredictions> _futureQueryAutocompletePredictions;
  var _uuid = Uuid();
  String _sessionToken;

  @override
  void initState() {
    super.initState();
    _searching = false;
    _sessionToken = _uuid.v1();
    print('$_sessionToken');
  }

  Future<QueryAutocompletePredictions> _getPredictions() async{
    String _URL = "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=$_APIKEY&input=$_searchTerm&sessiontoken=$_sessionToken";
    final _predictionsJSON = await http.get(_URL);
    _parsedJson = jsonDecode(_predictionsJSON.body);
    _placesPredictions = QueryAutocompletePredictions.fromJson(_parsedJson);
    return _placesPredictions;
  }

  Future<void> _textFieldChange(String value) async{
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
        new FutureBuilder(
          future: _futureQueryAutocompletePredictions = _getPredictions(),
          builder: (BuildContext context, AsyncSnapshot<QueryAutocompletePredictions> snapshot){
            Widget recommendedList;
            if (snapshot.hasData) {
               recommendedList = ListView.builder(
                itemCount: snapshot.data.predictions == null ? 0 : snapshot.data.predictions.length,
                itemBuilder: (BuildContext context, int index) {
                  return new ListTile(
                    title: new Text('${snapshot.data.predictions[index].description}'),
                  );
                },
               );
            } else {
              recommendedList = ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return new ListTile(
                    title: new Text('$_searchTerm'),
                  );
                },
              );
            }
            return Flexible(
              child: recommendedList,
            );
          },
        )
      );
    }
    return builder;
  }
}