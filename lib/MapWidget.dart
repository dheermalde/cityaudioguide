import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Logic.dart';

class MapWidget extends StatefulWidget {
  final Logic _logic;
  final Function _callback;

  MapWidget(this._logic, this._callback);

  @override
  MapWidgetState createState() => MapWidgetState(this._logic, this._callback);
}

class MapWidgetState extends State<MapWidget> {
  final Logic _logic;
  final Function _callback;

  MapWidgetState(this._logic, this._callback);

  @override
  void initState() {
    _logic.mapLogic.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _mapWidget(context),
    );
  }

  Widget _mapWidget(BuildContext context){
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _logic.mapLogic.onMapCreated,
        initialCameraPosition:  CameraPosition(
            target: _logic.mapLogic.startingPosition,
            zoom: 11
        ),
        markers: _logic.mapLogic.allMarkers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}