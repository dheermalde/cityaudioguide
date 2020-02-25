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
  bool _searching; // State check for searching // searching 状态
  bool _searched; // State check for searched // searched 状态
  String _searchTerm; // Search term // 搜索詞
  String _APIKEY = <APIKEY>; //api 金鑰 (Google Places)
  var _parsedJson; // Parsed JSON from http get // 解析完的JSON
  var _placesPredictions; // QueryAutocompletePredictions class data // QueryAutocompletePrediction 内容
  var _uuid = Uuid(); // uuid to create session token // 為生產session token 的東西
  String _sessionToken; // session token // session验证碼
  TextEditingController _searchQueryController = TextEditingController();
  String _searchResult; // 最後結果

  @override
  void initState() {
    // Initial state of application
    // App 的原始狀態
    super.initState();
    _searching = false;
    _sessionToken = _uuid.v1();
    _searched = false;
  }

  Future<QueryAutocompletePredictions> _getPredictions() async{
    // Get JSON from http and parse into QueryAutocompletePredictions
    // 從網頁得到的JSON變成QueryAutocompletePrediction内容
    String _URL = "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=$_APIKEY&input=$_searchTerm&sessiontoken=$_sessionToken";
    final _predictionsJSON = await http.get(_URL);
    _parsedJson = jsonDecode(_predictionsJSON.body);
    _placesPredictions = QueryAutocompletePredictions.fromJson(_parsedJson);
    print("https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=$_APIKEY&input=$_searchTerm&sessiontoken=$_sessionToken");
    return _placesPredictions; // Predictions in a QueryAutocompletePredictions class
  }

  Future<void> _textFieldChange(String value) async{
    // setState when there is a change in values in the search bar
    // 當正在搜索詞變時，更新app狀態
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

  _selectSearchResult(BuildContext context, String result){
    // setState when a search result is selected
    // 當選擇選項時，更新app狀態
    FocusScope.of(context).unfocus(); // removes keyboard from screen
    setState(() {
      _searchResult = result;
      _searching = false;
      _searchQueryController.clear();
      _searchTerm = "";
      _sessionToken = _uuid.v1();
      _searched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidgetBuilder(context, 'Search Screen'),
      body: _buildSearchWidget(context), // main application for this page
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

  List<Widget> _searchWidgetList() {
    // Search widget
    // 搜索部件
    var builder = <Widget>[
      new TextField(
        controller: _searchQueryController,
        onChanged: _textFieldChange,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          suffixIcon: Icon(Icons.search),
        )
      ),
    ];
    if (_searched) {
      // if _searched is true add a card containing search result under search bar
      // 當 _searched = true 在搜索欄下面加個card顯示搜索結果
      builder.add(
        new Container(
          child: Card(
            child: Text("search result : $_searchResult"),
          )
        )
      );
    }
    if (_searching) {
      builder.add(
        new FutureBuilder(
          // builds predictions for results
          // 搜索建議部件
          future: _getPredictions(),
          builder: (BuildContext context, AsyncSnapshot<QueryAutocompletePredictions> snapshot){
            Widget recommendedList;
            if (snapshot.hasData) {
               recommendedList = ListView.builder(
                itemCount: snapshot.data.predictions == null ? 0 : snapshot.data.predictions.length,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    child: ListTile(
                      title: new Text('${snapshot.data.predictions[index].description}'),
                    ),
                    onTap: () => _selectSearchResult(context, snapshot.data.predictions[index].description),
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
