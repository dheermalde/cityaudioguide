import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLogic{
  GoogleMapController mapController;
  LatLng startingPosition;
  Marker searchMarker;
  Set<Marker> allMarkers;

  void init(){
    allMarkers = Set<Marker>();
  }

  MapLogic({LatLng startLatLng = const LatLng(51.481583, -3.179090)}){
    startingPosition = startLatLng;
  }

  void setSearchMarker(double lat, double lng, String placeID){
    var _temp;
    allMarkers.forEach((element) {
      if (element.markerId.value.startsWith('searchMarker:')){
        _temp = element;
      }
    });
    allMarkers.remove(_temp);
    searchMarker = Marker(
      markerId: MarkerId('searchMarker:$placeID'),
      position: LatLng(lat, lng),
    );
    allMarkers.add(searchMarker);
  }

  void onMapCreated(GoogleMapController controller){
    mapController = controller;
  }
}