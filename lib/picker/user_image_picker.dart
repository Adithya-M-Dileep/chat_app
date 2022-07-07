import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class UserImagePicker extends StatefulWidget {
  Function(File image) ImagePickFn;
  UserImagePicker(this.ImagePickFn);
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _imagePicked;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 150,
      maxWidth: 150,
      imageQuality: 50,
    );
    if (pickedImageFile == null) return;
    setState(() {
      _imagePicked = File(pickedImageFile.path);
    });
    widget.ImagePickFn(_imagePicked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _imagePicked != null ? FileImage(_imagePicked) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            "Take an Image",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
