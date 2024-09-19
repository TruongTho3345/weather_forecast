import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/constant/api_constants.dart';
import 'package:weather_forecast/model/location_model.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<List<LocationModel>> getLocationCoordinates(
      String locationName) async {
    final String url =
        'https://api.opencagedata.com/geocode/v1/json?q=$locationName&key=${ApiConstants.apiGeocoding}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>;

      return results
          .map((result) => LocationModel(
                formatted: result['formatted'],
                lat: result['geometry']['lat'],
                lng: result['geometry']['lng'],
              ))
          .toList();
    } else {
      throw Exception('Failed to load location data');
    }
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Exception('Location permissions are denied.');
      }
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Minimum distance a device must move before an update
    );

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

}
