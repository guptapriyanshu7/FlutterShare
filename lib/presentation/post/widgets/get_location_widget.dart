import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationWidget extends StatelessWidget {
  final locationController = TextEditingController();

  GetLocationWidget({Key? key}) : super(key: key);

  Future<void> getLocation() async {
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
    locationController.text = formattedAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.pin_drop,
            color: Theme.of(context).primaryColor,
            size: 35,
          ),
          title: TextField(
            controller: locationController,
            decoration: const InputDecoration(
              hintText: 'Location...',
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 200,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: getLocation,
            icon: const Icon(Icons.my_location),
            label: const Text('Current Location'),
          ),
        ),
      ],
    );
  }
}
