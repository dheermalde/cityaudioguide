import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  LatLng _startMapPosition = const LatLng(51.481583, -3.179090);

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidgetBuilder(context, 'Map Screen'),
      body: _mapWidget(context),
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

  Widget _mapWidget(BuildContext context){
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition:  CameraPosition(
            target: _startMapPosition,
            zoom: 11
        ),
      ),
    );
  }
}