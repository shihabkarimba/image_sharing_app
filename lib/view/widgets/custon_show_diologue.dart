
 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

Future<void> customShowDialog(BuildContext context) async {
  final _MyKey = GlobalKey();
  final pickedFile = await showDialog<XFile>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        key: _MyKey,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            
            TextButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  // Do something with the pickedFile here.
                }
                Navigator.of(context).pop(pickedFile);
              },
              child: Text(
                'From Camera',
                style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  // Do something with the pickedFile here.
                }
                Navigator.of(context).pop(pickedFile);
              },
              child: Text(
                'From Gallery',
                style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Customize the cancel button color
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

    // if (pickedFile != null) {
    //   // Upload the selected image to Firebase Storage
    //   final downloadUrl = await uploadImageToFirebaseStorage(pickedFile);
    //   if (downloadUrl != null) {
    //     // Do something with the downloadUrl (e.g., save it to Firebase Firestore or update the user's profile)
    //     print('Image uploaded to Firebase Storage: $downloadUrl');
    //   } else {
    //     // Handle the error
    //     print('Failed to upload image to Firebase Storage.');
    //   }
    // }
  }