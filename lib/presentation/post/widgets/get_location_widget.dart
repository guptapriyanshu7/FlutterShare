import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/post/save_post/save_post_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationWidget extends StatelessWidget {
  final _locationController = TextEditingController();

  GetLocationWidget({Key? key}) : super(key: key);

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
          title: TextFormField(
            controller: _locationController,
            // onChanged: (value) {
            //   _locationController.text = value;
            //   context.read<SavePostBloc>().add(
            //         SavePostEvent.locationChanged(value),
            //       );
            // },
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
            onPressed: () async {
              final value = await getLocation();
              _locationController.text = value;
              context.read<SavePostBloc>().add(
                    SavePostEvent.locationChanged(value),
                  );
            },
            icon: const Icon(Icons.my_location),
            label: const Text('Current Location'),
          ),
        ),
      ],
    );
  }
}
