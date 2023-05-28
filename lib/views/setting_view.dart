import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:swipe_me/commenwidget/appbarwidget.dart';
import 'package:swipe_me/content.dart';
import 'package:swipe_me/views/loginpage.dart';
import 'package:swipe_me/views/save_view.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final ImagePicker _imagePicker = ImagePicker();
  File? selectedImage;
  String base64Image = "";
  Future<void> getImage(type) async {
    XFile? image;
    if (type == "camera") {
      image = await _imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await _imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image!.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
  }

// for displaying snackbars
  showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  Uint8List? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Setting"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile",
              style: hdText,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 5.0, right: 15, bottom: 10),
                  child: Stack(children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      child: _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                              backgroundColor: Colors.grey,
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  "https://sohohindi.in/wp-content/uploads/2022/09/1_good-morning-images-Sohohindi.in_.jpg"),
                              backgroundColor: Colors.grey,
                            ),
                    ),
                    Positioned(
                        bottom: -7,
                        right: -7,
                        child: IconButton(
                          icon: Material(
                              borderRadius: BorderRadius.circular(50),
                              child: const Icon(
                                Icons.add_circle,
                                color: Colors.blue,
                                size: 18,
                              )),
                          onPressed: () {
                            selectImage();
                          },
                        ))
                  ]),
                ),
                const Text(
                  "name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Theme',
                style: hdText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SaveImage()));
                  },
                  child: const Text("save", style: hdText)),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      });
                    },
                    child: const Text("Logout", style: hdText)))
          ],
        ),
      ),
    );
  }
}
