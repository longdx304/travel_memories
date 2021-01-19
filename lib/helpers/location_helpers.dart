import 'dart:convert';

import 'package:http/http.dart';

const _GOOGLE_API_KEY = 'AIzaSyCeiP61TcSNocuXKLPBj4g58veWmrQKjes';

class LocationHelpers {
  static String generateLocationPreviewImage({
    double longitude,
    double latitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$_GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress({
    double longitude,
    double latitude,
  }) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_GOOGLE_API_KEY';
    try {
      final res = await get(url);
      return json.decode(res.body)['results'][0]['formatted_address'];
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
