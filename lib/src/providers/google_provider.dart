import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:clone_uber_app/src/api/environment.dart';
import 'package:clone_uber_app/src/models/directions.dart';

class GoogleProvider {

  Future<dynamic> getGoogleMapsDirections(double fromLat, double fromLng, double toLat, double toLng) async {

    Uri uri = Uri.https(
        'maps.googleapis.com',
        'maps/api/directions/json', {
          'key': Environment.API_KEY_MAPS,
          'origin': '$fromLat,$fromLng',
          'destination': '$toLat,$toLng',
          'traffic_model': 'best_guess',
          'departure_time' : DateTime.now().millisecondsSinceEpoch.toString(),
          'mode' : 'driving',
          'transit_routing_preferences': 'less_driving'
      }
    );
    print('URL $uri');
    final response = await http.get(uri);
    final decodeData = json.decode(response.body);
    final leg = new Direction.fromJsonMap(decodeData['routes'][0]['legs'][0]);
    return leg;

  }

}