import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/application/post/save_post/save_post_bloc.dart';
import 'package:flutter_share/helper/helper_functions.dart';

class GetLocationWidget extends HookWidget {
  const GetLocationWidget({Key? key}) : super(key: key);

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
          title: BlocListener<SavePostBloc, SavePostState>(
            listenWhen: (previous, current) => previous.isSaving == true,
            listener: (context, state) {
              if (state.failureOption.isNone()) _locationController.clear();
            },
            child: TextFormField(
              controller: _locationController,
              onChanged: (value) => context
                  .read<SavePostBloc>()
                  .add(SavePostEvent.locationChanged(value)),
              decoration: const InputDecoration(
                hintText: 'Location...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        _LocationIcon(locationController: _locationController),
      ],
    );
  }
}

class _LocationIcon extends StatelessWidget {
  const _LocationIcon({
    Key? key,
    required this.locationController,
  }) : super(key: key);

  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          locationController.text = value;
          context.read<SavePostBloc>().add(
                SavePostEvent.locationChanged(value),
              );
        },
        icon: const Icon(Icons.my_location),
        label: const Text('Current Location'),
      ),
    );
  }
}
