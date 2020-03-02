import 'dart:convert';
import 'package:flutter/material.dart';
import 'NearbyPlacesJSON.dart';

class TestScreen extends StatefulWidget {
  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {

  static var nearbyJSON = '''
  {html_attributions: [], results: [{geometry: {location: {lat: 51.48529509999999, lng: -3.1787319}, viewport: {northeast: {lat: 51.48626592989272, lng: -3.177528020107277}, southwest: {lat: 51.48356627010727, lng: -3.180227679892722}}}, icon: https://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png, id: 6df211188cb4ba05969d5a2110c5b10bd1bd6203, name: City Hall, photos: [{height: 2544, html_attributions: [<a href="https://maps.google.com/maps/contrib/116283205670597279076">Dom Clarke</a>], photo_reference: CmRaAAAA_5e1rT8NyhKfcEKZZGycx5PzK0KgqyQrM090G68rPr8Vz_YXA2tXlkVDF3IofcbqJMSYTDDV1xa2hKzHIFg2uS9dbBtMoirCwKlL7Nb3phgTrsQ7rp1hBoVNtFcnKnlQEhCoio39DBk0qukTDS2K27n-GhTA6SL1udAe4i3DOBSN-2M9M7gN4Q, width: 3201}], place_id: ChIJP66sVLocbkgRV032DVt8u7o, reference: ChIJP66sVLocbkgRV032DVt8u7o, scope: GOOGLE, types: [premise], vicinity: Cardiff}], status: OK}
  ''';
  var parsedJson;
  var nearbyPlaces;
  List<NearbyPlacesJSON> nearbyPlacesList = new List<NearbyPlacesJSON>();

  @override
  void initState() {
    super.initState();
    parsedJson = jsonDecode(nearbyJSON);
    nearbyPlaces = NearbyPlacesJSON.fromJson(parsedJson);
    nearbyPlacesList.add(nearbyPlaces);
    print(nearbyJSON);
    print('${nearbyPlaces.runtimeType}');
    print(nearbyPlacesList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: ListView.builder(
          itemCount: nearbyPlaces.results == null ? 0 : nearbyPlaces.results.length,
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
              title: new Text('${nearbyPlaces.results[index].geometry.location.lat}, ${nearbyPlaces.results[index].geometry.location.lng}, ${nearbyPlaces.results[index].name}'),
            );
          },
        )
      )
    );
  }

}