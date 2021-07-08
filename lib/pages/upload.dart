import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/progress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_share/pages/home.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> with AutomaticKeepAliveClientMixin {
  File? file;
  bool isUploading = false;
  String postId = const Uuid().v4();
  final captionController = TextEditingController();
  final locationController = TextEditingController();

  void selectImage() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Create Post'),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              final pickedFile =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              setState(() {
                this.file = pickedFile != null ? File(pickedFile.path) : null;
              });
            },
            child: const Text('Choose from gallery'),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              final pickedFile =
                  await ImagePicker().getImage(source: ImageSource.camera);
              setState(() {
                this.file = pickedFile != null ? File(pickedFile.path) : null;
              });
            },
            child: const Text('Click a photo'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void clearImage() {
    setState(() {
      file = null;
    });
  }

  Future<void> uploadPost() async {
    print('Uploading');
    setState(() {
      isUploading = true;
    });
    await compressImage();
    await uploadtoFirebase();
    captionController.clear();
    locationController.clear();
    setState(() {
      isUploading = false;
      file = null;
      postId = const Uuid().v4();
    });
  }

  Future<void> compressImage() async {
    final dir = await getTemporaryDirectory();
    final path = dir.path;
    // final path = file.parent.path;
    final im.Image? image = im.decodeImage(file!.readAsBytesSync());
    final compressedImage =
        image != null ? File('$path/img_$postId.jpg') : null;
    compressedImage?.writeAsBytesSync(
      im.encodeJpg(image!, quality: 85),
    );
    setState(() {
      file = compressedImage;
    });
  }

  Future<void> uploadtoFirebase() async {
    final snap = await storage.ref('post_$postId.jpg').putFile(file!);
    final url = await snap.ref.getDownloadURL();
    savePostinFirebase(url);
  }

  void savePostinFirebase(String url) {
    postsRef.doc(currentUser!.id).collection('userPosts').doc(postId).set({
      'mediaUrl': url,
      'ownerid': currentUser!.id,
      'caption': captionController.text,
      'location': locationController.text,
      'timestamp': DateTime.now(),
      'likes': {},
    });
  }

  Future<void> getLocation() async {
    print('getLocation');
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final placemark = placemarks[0];
    print(placemark);
    final String formattedAddress =
        "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
    locationController.text = formattedAddress;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return file == null
        ? Container(
            color: Theme.of(context).accentColor,
            child: Center(
              child: ElevatedButton(
                onPressed: () => selectImage(),
                child: const Text('Upload Image'),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text('Caption Post'),
              actions: [
                TextButton(
                  onPressed: isUploading ? null : uploadPost,
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            body: ListView(
              children: [
                if (isUploading) linearIndicator() else const Text(''),
                SizedBox(
                  height: 220,
                  // width: MediaQuery.of(context).size.width * 0.8,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(file!),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      currentUser!.photoUrl,
                    ),
                  ),
                  title: TextField(
                    controller: captionController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a Caption...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(),
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
                )
              ],
            ),
          );
  }
}
