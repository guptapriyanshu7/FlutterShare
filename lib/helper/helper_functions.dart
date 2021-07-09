import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> getLocation() async {
  print('getLocation');
  final position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  final placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );
  final placemark = placemarks[0];
  print(placemark);
  final String formattedAddress =
      "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
  return formattedAddress;
}
