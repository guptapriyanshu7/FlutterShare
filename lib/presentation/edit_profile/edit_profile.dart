import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/injection.dart';

class EditProfile extends StatefulWidget {
  final User currentUser;

  const EditProfile({required this.currentUser});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool _displayNameValid = true;
  bool _bioValid = true;

  @override
  void initState() {
    super.initState();
    // getUser();
  }

  // getUser(User user) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final doc = await getIt<FirebaseFirestore>().doc(user.id).get();
  //   user = User.fromJson(doc.data()!);
  //   displayNameController.text = user.displayName;
  //   bioController.text = user.bio;
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  void updateProfileData(String name, String bio, User user) {
    setState(() {
      name.trim().length < 3 || name.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;
      bio.trim().length > 100 ? _bioValid = false : _bioValid = true;
    });

    if (_displayNameValid && _bioValid) {
      getIt<FirebaseFirestore>().doc(user.id).update({
        "displayName": name,
        "bio": name,
      });
      const snackbar = SnackBar(content: Text("Profile updated!"));
      ScaffoldMessenger(key: _scaffoldKey, child: snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = widget.currentUser;
    final TextEditingController displayNameController =
        TextEditingController(text: user.displayName);
    final TextEditingController bioController =
        TextEditingController(text: user.bio);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("Edit Profile")),
      body: isLoading
          ? const CircularProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 8.0,
                  ),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      _BuildDisplayNameField(
                        displayNameValid: _displayNameValid,
                        displayNameController: displayNameController,
                      ),
                      _BuildBioField(
                        bioValid: _bioValid,
                        bioController: bioController,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => updateProfileData(
                    displayNameController.text,
                    bioController.text,
                    user,
                  ),
                  child: const Text("Update Profile"),
                ),
              ],
            ),
    );
  }
}

class _BuildBioField extends StatelessWidget {
  const _BuildBioField({
    Key? key,
    required this.bioValid,
    required this.bioController,
  }) : super(key: key);

  final bool bioValid;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: "Update Bio",
            errorText: bioValid ? null : "Bio too long",
          ),
        )
      ],
    );
  }
}

class _BuildDisplayNameField extends StatelessWidget {
  const _BuildDisplayNameField({
    Key? key,
    required this.displayNameValid,
    required this.displayNameController,
  }) : super(key: key);

  final bool displayNameValid;
  final TextEditingController displayNameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Display Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update Display Name",
            errorText: displayNameValid ? null : "Display Name too short",
          ),
        )
      ],
    );
  }
}
