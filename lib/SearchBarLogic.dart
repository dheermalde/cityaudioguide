import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'dart:convert';

import 'QueryAutocompletePredictions.dart';
import 'PlaceID.dart';

class SearchBarLogic{
  final _searchQueryController = TextEditingController();
  bool _searching = false;
  bool _searched = false;
  String _searchTerm;
  final _uuid = Uuid();
  String _sessionToken;
  static const String _apiKey = "APIKEY";
  var _predictionsFuture;
  var _searchResult;

  void newSessionToken() {
    _sessionToken = _uuid.v1();
  }

  Future<PlaceID> selectSearchResult(var result) async{
    _searchResult = result;
    _searching = false;
    _searchQueryController.clear();
    _searchTerm = "";
    _sessionToken = _uuid.v1();
    _searched = true;
    return await _getPlaceID();
  }

  TextEditingController get searchQueryController => _searchQueryController;
  bool get searching => _searching;
  bool get searched => _searched;
  String get searchTerm => _searchTerm;
  Future get predictionsFuture => _predictionsFuture;
  Predictions get searchResult => _searchResult;

  Future<QueryAutocompletePredictions> _getPredictions() async {
    // Get JSON from http and parse into QueryAutocompletePredictions
    // 從網頁得到的JSON變成QueryAutocompletePrediction内容
    String _searchTermQuery = _searchTerm.replaceAll(RegExp(' +'), '%20');
    String _url = "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=$_apiKey&input=$_searchTermQuery&sessiontoken=$_sessionToken&fields=geometry,place_id";
    final _predictionsJSON = await http.get(_url);
    var _parsedJson = jsonDecode(_predictionsJSON.body);
    var _placesPredictions = QueryAutocompletePredictions.fromJson(_parsedJson);
    return _placesPredictions; // Predictions in a QueryAutocompletePredictions class
  }

  Future<PlaceID> _getPlaceID() async {
    String _searchTermQuery = _searchResult.description.replaceAll(RegExp(' +'), '%20');
    String _url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=$_apiKey&input=$_searchTermQuery&inputtype=textquery&fields=geometry,place_id";
    final _predictionsJSON = await http.get(_url);
    var _parsedJson = jsonDecode(_predictionsJSON.body);
    var _placeID = PlaceID.fromJson(_parsedJson);
    return _placeID; // Predictions in a QueryAutocompletePredictions class
  }

  void textFieldChanged() async {
    if (_searchQueryController.text != '') {
      _searching = true;
      _searchTerm = _searchQueryController.text;
      _predictionsFuture = _getPredictions();
    } else {
      _searching = false;
      _searchTerm = '';
    }
  }
}
