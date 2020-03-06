import 'MapLogic.dart';
import 'SearchBarLogic.dart';

class Logic{
  final MapLogic _mapLogicObj = new MapLogic();
  final SearchBarLogic _searchBarLogicObj = new SearchBarLogic();

  MapLogic get mapLogic => _mapLogicObj;
  SearchBarLogic get searchBarLogic => _searchBarLogicObj;
}