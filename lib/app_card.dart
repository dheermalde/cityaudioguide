import 'package:flutter/material.dart';

class  AppCard extends StatefulWidget{
  final Widget  child;
  final Border borderStyle;
  final Color  boxShadowColor;

  AppCard({@required this.child, this.borderStyle, this.boxShadowColor});
  @override
  _AppCardState createState() => new _AppCardState();
}

class _AppCardState  extends State<AppCard>{
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Card(
          margin: EdgeInsets.all(15.0),
          color: Color.fromRGBO(255, 255, 255, 0.0),
          child: new Container(
            padding: EdgeInsets.all(20.0),
            child: widget.child,
            decoration: new BoxDecoration(
              //color: Color.fromRGBO(45, 20, 44, 0.0),
              /*border: widget.borderStyle ??
                Border.all(
                  color: Colors.amber,
                      width: 2,
                ),*/
              /*boxShadow: [
                new BoxShadow(
                  color: widget.boxShadowColor ?? Color.fromRGBO(255, 255, 255, 1.0),
                  offset: new Offset(10.0, 10.0),
                )
              ]*/
            ),
          ),
        )
      ]
    );
  }
}