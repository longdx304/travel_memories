const _GOOGLE_API_KEY = 'AIzaSyCeiP61TcSNocuXKLPBj4g58veWmrQKjes';

class LocationHelpers {
  static String generateLocationPreviewImage({
    double longitude,
    double latitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$_GOOGLE_API_KEY';
  }
}
