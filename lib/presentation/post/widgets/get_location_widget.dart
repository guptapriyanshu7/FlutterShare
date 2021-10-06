import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/application/post/save_post/save_post_bloc.dart';
import 'package:flutter_share/helper/helper_functions.dart';

class GetLocationWidget extends HookWidget {
  const GetLocationWidget({Key? key}) : super(key: key);

  void _addLocationChangedEvent(BuildContext context, String value) {
    context.read<SavePostBloc>().add(
          SavePostEvent.locationChanged(value),
        );
  }

  @override
  Widget build(BuildContext context) {
    final _locationController = useTextEditingController();
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
            onChanged: (value) => _addLocationChangedEvent(context, value),
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
              _addLocationChangedEvent(context, value);
            },
            icon: const Icon(Icons.my_location),
            label: const Text('Current Location'),
          ),
        ),
      ],
    );
  }
}
