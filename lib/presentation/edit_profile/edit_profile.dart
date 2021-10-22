import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/application/auth/auth_bloc.dart';
import 'package:flutter_share/application/user_actions/user_actions_bloc.dart';
import 'package:flutter_share/domain/core/errors.dart';
import 'package:flutter_share/injection.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);
  // void updateProfileData(String name, String bio, User user) {
  //   setState(() {
  //     name.trim().length < 3 || name.isEmpty
  //         ? _displayNameValid = false
  //         : _displayNameValid = true;
  //     bio.trim().length > 100 ? _bioValid = false : _bioValid = true;
  //   });

  //   if (_displayNameValid && _bioValid) {
  //     getIt<FirebaseFirestore>().doc(user.id).update({
  //       "displayName": name,
  //       "bio": name,
  //     });
  //     const snackbar = SnackBar(content: Text("Profile updated!"));
  //     ScaffoldMessenger(key: _scaffoldKey, child: snackbar);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserActionsBloc>(),
      child: BlocBuilder<UserActionsBloc, UserActionsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Edit Profile")),
            body: state.maybeMap(
              loading: (value) =>
                  const Center(child: CircularProgressIndicator()),
              orElse: () => const _BuildContent(),
            ),
          );
        },
      ),
    );
  }
}

class _BuildContent extends HookWidget {
  const _BuildContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authState = context.read<AuthBloc>().state;
    final user = _authState.maybeMap(
      authenticated: (_) => _.currentUser,
      orElse: () => throw NotAuthenticatedError(),
    );

    final displayNameController =
        useTextEditingController(text: user.displayName);
    final bioController = useTextEditingController(text: user.bio);

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            foregroundImage: CachedNetworkImageProvider(user.photoUrl),
          ),
        ),
        const SizedBox(height: 10),
        _BuildDisplayNameField(
          displayNameController: displayNameController,
        ),
        const SizedBox(height: 10),
        _BuildBioField(bioController: bioController),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => context.read<UserActionsBloc>().add(
                UserActionsEvent.editProfile(
                  displayNameController.text,
                  bioController.text,
                ),
              ),
          child: const Text("Update Profile"),
        ),
      ],
    );
  }
}

class _BuildBioField extends StatelessWidget {
  const _BuildBioField({
    Key? key,
    required this.bioController,
  }) : super(key: key);

  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: bioController,
      decoration: const InputDecoration(
        labelText: "Bio",
        // errorText: bioValid ? null : "Bio too long",
      ),
    );
  }
}

class _BuildDisplayNameField extends StatelessWidget {
  const _BuildDisplayNameField({
    Key? key,
    required this.displayNameController,
  }) : super(key: key);

  final TextEditingController displayNameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: displayNameController,
      decoration: const InputDecoration(
        labelText: "Display Name",
        // errorText: displayNameValid ? null : "Display Name too short",
      ),
    );
  }
}
