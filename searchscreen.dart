import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  void _textFieldChanged(String value) async{
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidgetBuilder(context, 'Search Screen'),
      body: _SearchWidget(context),
    );
  }

  Widget _appBarWidgetBuilder(BuildContext context, String titleName){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {Navigator.pop(context);},
      ),
      title: Text('$titleName'),
    );
  }

  Widget _SearchWidget(BuildContext context){
    return Container (
        child: Stack(
            children: <Widget>[
              Container(
                color: Color(0xFF000000),
                child: Center(
                  child: Text(
                    'MAP GOES HERE',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ), Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Card(
                    child: TextField(
                      onChanged: _textFieldChanged,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        suffixIcon: Icon(Icons.search),
                      ),
                    )
                ),
              )
            ]
        )
    );
  }
}