import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  const Upload({Key key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  PickedFile file;
  void selectImage() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Create Post'),
        children: [
          SimpleDialogOption(
            child: Text('Choose from gallery'),
            onPressed: () async {
              Navigator.pop(context);
              var file =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              setState(() {
                this.file = file;
              });
            },
          ),
          SimpleDialogOption(
            child: Text('Click a photo'),
            onPressed: () async {
              Navigator.pop(context);
              var file =
                  await ImagePicker().getImage(source: ImageSource.camera);
              setState(() {
                this.file = file;
              });
            },
          ),
          SimpleDialogOption(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return file == null
        ? Container(
            color: Theme.of(context).accentColor,
            child: Center(
              child: ElevatedButton(
                onPressed: () => selectImage(),
                child: Text('Upload Image'),
              ),
            ),
          )
        : Text('Image Chosen');
  }
}
