import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Logic.dart';

class SearchBarWidget extends StatefulWidget {
  final Logic _logic;
  final Function _callback;

  SearchBarWidget(this._logic, this._callback);

  @override
  SearchBarWidgetState createState() => SearchBarWidgetState(_logic, _callback);
}

class SearchBarWidgetState extends State<SearchBarWidget>{
  final Logic _logic;
  final Function _callback;

  SearchBarWidgetState(this._logic, this._callback);

  @override
  void initState() {
    super.initState();
    _logic.searchBarLogic.newSessionToken();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top), //height of status bar
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _searchWidgetList(),
        ),
      ),
    );
  }

  List<Widget> _searchWidgetList() {
    // Search widget
    // 搜索部件
    var _builder = <Widget>[
      new TextField(
          controller: _logic.searchBarLogic.searchQueryController,
          onChanged: (text) {
            _logic.searchBarLogic.textFieldChanged();
            _callback();
          },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          suffixIcon: Icon(Icons.search),
          contentPadding: const EdgeInsets.all(15.0),
        )
      ),
    ];
    if(_logic.searchBarLogic.searching) {
      _builder.add(
//        new Text("${_logic.searchBarLogic.searchTerm}")
          new FutureBuilder(
            // builds predictions for results
            // 搜索建議部件
            future: _logic.searchBarLogic.predictionsFuture,
            builder: (context, snapshot){
              Widget recommendedList;
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.data.status == 'ZERO_RESULTS') {
                    recommendedList = ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return new ListTile(
                          title: new Text('No results'),
                        );
                      },
                    );
                  } else {
                    recommendedList = ListView.builder(
                      itemCount: snapshot.data.predictions == null ? 0 : snapshot.data.predictions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new GestureDetector(
                          child: ListTile(
                            title: new Text('${snapshot.data.predictions[index].description}'),
                          ),
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            var _placeID = await _logic.searchBarLogic.selectSearchResult(snapshot.data.predictions[index]);
                            _logic.mapLogic.setSearchMarker(_placeID.candidates[0].geometry.location.lat, _placeID.candidates[0].geometry.location.lng, _placeID.candidates[0].placeId);
                            _callback();
                          },
                        );
                      },
                    );
                  }
                  return Flexible(
                    child: recommendedList,
                  );
                case ConnectionState.active:
                case ConnectionState.waiting:
                recommendedList = ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return new ListTile(
                      title: new Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    );
                  },
                );
                return Flexible(
                  child: recommendedList,
                );
                case ConnectionState.none:
                  recommendedList = ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return new ListTile(
                        title: new Text('No results'),
                      );
                    },
                  );
                  return Flexible(
                    child: recommendedList,
                  );
                default:
                  recommendedList = ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return new ListTile(
                        title: new Text('${_logic.searchBarLogic.searchTerm}'),
                      );
                    },
                  );
                  return Flexible(
                    child: recommendedList,
                  );
              }
            },
          )
      );
    }

    return _builder;
  }
}