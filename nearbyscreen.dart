import 'package:flutter/material.dart';
import 'NearbyPlacesJSON.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearbyScreen extends StatefulWidget {
  @override
  NearbyScreenState createState() => NearbyScreenState();
}

class NearbyScreenState extends State<NearbyScreen> {
  bool _filtering;
  Map<String, bool> _filters = Map();
  List<String> _filterNames = ["Amusement Park", "Aquarium", "City Hall",
    "Museum", "Park", "Restaurant", "Shopping Mall", "Stadium", "Store",
    "Tourist Attraction", "Zoo"
  ];
  var _parsedJson;
  var _nearbyPlacesResults;
  List<NearbyPlacesJSON> _nearbyPlacesList = new List<NearbyPlacesJSON>();
  bool _searched;
  String _APIKEY = <APIKEY>;
  double _lat = 51.481583;
  double _lng = -3.179090;

  Future<List<NearbyPlacesJSON>> _getNearbyPlaces() async{
    for (var key in _filters.keys){
      if (_filters[key]){
        String _searchFilter = key.replaceAll(RegExp(' +'), '_').toLowerCase();
        String _URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$_lat,$_lng&radius=1500&&keyword=$_searchFilter&key=$_APIKEY";
        final _filterJSON = await http.get(_URL);
        _parsedJson = jsonDecode(_filterJSON.body);
        _nearbyPlacesResults = NearbyPlacesJSON.fromJson(_parsedJson);
        _nearbyPlacesList.add(_nearbyPlacesResults);
      }
    }
    return _nearbyPlacesList;
  }

  void _filterButtonPressed(){
    setState(() {
      _filtering = true;
    });
  }

  void _searchButtonPressed() {
    setState(() {
      _searched = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _filtering = false;
    _searched = false;
    for(var i=0; i < _filterNames.length; i++){
      _filters[_filterNames[i]] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidgetBuilder(context, 'Search Screen'),
      body: _buildNearbyWidget(context), // main application for this page
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

  Widget _buildNearbyWidget(BuildContext context) {
    var _builder = <Widget>[
      _backgroundWidget(context),
      _filterWidget(context),
      _searchWidget(context),
    ];
    if(_filtering){
      _builder.add(
        new Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Card(
              child: _filterBoxWidgetBuilder(context),
            ),
          ),
        )
      );
    }
    return Stack(
      children: _builder,
    );
  }

  Widget _searchWidget(BuildContext context) {
    var _builder = <Widget>[
      RaisedButton(
      child: Text("Search This Area"),
      onPressed: () => _searchButtonPressed(),
      ),
    ];
    if(_searched){
      _builder.add(
        new FutureBuilder(
          future: _getNearbyPlaces(),
          builder: (BuildContext context, AsyncSnapshot<List<NearbyPlacesJSON>> snapshot){
            var _nearbyList = <Widget>[];
            if (snapshot.hasData) {
              for(int i=0; i < snapshot.data.length; i++){
                for(int j=0; j < snapshot.data[i].results.length; j++){
                  _nearbyList.add(
                      new ListTile(
                        title: Text("${snapshot.data[i].results[j].geometry.location.lat}, ${snapshot.data[i].results[j].geometry.location.lng}, ${snapshot.data[i].results[j].name}"),
                      )
                  );
                }
              }
            }
            return Card(
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: _nearbyList,
                ).toList(),
              )
            );
          },
        )
      );
    }
    return Stack(
      children: _builder,
    );
  }

  Widget _filterBoxWidgetBuilder(BuildContext context) {
    var _builder = <Widget>[
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              _filtering = false;
            });
          },
        ),
      )
    ];
    _builder.add(
      new Padding(
        padding: EdgeInsets.only(left: 10.0, bottom: 3.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Filters",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
      ),
    );
    var _cardBuilder = <Widget>[];
    for (var key in _filters.keys){
      _cardBuilder.add(
          FilterChip(
            label: Text(key),
            selected: _filters[key],
            backgroundColor: Colors.deepPurpleAccent,
            onSelected: (isSelected) {
              setState(() {
                _filters[key] = isSelected;
              });
            },
            selectedColor: Colors.deepPurple,
          )
      );
    }
    _builder.add(
      Wrap(
        spacing: 5.0,
        children: _cardBuilder,
      )
    );
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _builder,
      ),
    );
  }

  Widget _backgroundWidget(BuildContext context) {
    // Shows where the map will be
    // 佔map的位置
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

  Widget _filterWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Container(
          width: 100,
          height: 30,
          child: RaisedButton(
            onPressed: () => _filterButtonPressed(),
            color: Colors.deepPurple,
            textColor: Colors.white,
            child: Row(
              children: <Widget>[
                Icon(Icons.filter_list),
                Text('Filters')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
