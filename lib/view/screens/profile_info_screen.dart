import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_sharing_app/view/style/colors.dart';
import 'package:image_sharing_app/view/widgets/custon_show_diologue.dart';
import 'package:image_sharing_app/view/widgets/design.dart';
import 'package:image_sharing_app/view/widgets/info_container_feild.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  String _currentUserEmail = '';

  Future<String?> uploadImageToFirebaseStorage(XFile imageFile) async {
    try {
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('your_image_name.jpg'); // Set your desired image name here
      final task = await firebaseStorageRef.putFile(File(imageFile.path));
      final downloadUrl = await task.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }


  @override
  void initState() {
    // Fetch the current user's email when the screen is initialized
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _currentUserEmail = currentUser.email ?? '';
    }
    super.initState();
  }

  @override
  build(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        const PinkDesign(),
        Column(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.4,
              child: Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.3,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/image/defaultBgImage.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top:
                        screenHeight * .05, // Adjust the top position as needed
                    right: 10, // Adjust the right position as needed
                    child: Container(
                      decoration: BoxDecoration(
                          color: yelloColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              customShowDialog(context);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top:
                        screenHeight * 0.2, // Adjust the top position as needed
                    left: screenWidth *
                        0.15, // Adjust the left position as needed
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          50), // Circular clip for the profile picture
                      child: Container(
                        width: 150, // Adjust the width as needed
                        height: 150, // Adjust the height as needed
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/image/user (2).png'), // Replace with your profile image
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Handle editing the profile picture here
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Containerfield(
                text: 'Name',
                function: () {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Containerfield(
                text: _currentUserEmail,
                hasEdit: false,
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
