import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:image_sharing_app/view/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: unused_local_variable
  await Firebase.initializeApp(); // Ensure Firebase initialization completes

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('An error occurred')),
            );
          } else {
            return ConnectivityWidget(initialization: initialization);
          }
        },
      ),
    );
  }
}

class ConnectivityWidget extends StatelessWidget {
  final Future<FirebaseApp> initialization;

  const ConnectivityWidget({super.key, required this.initialization});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Connectivity().checkConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.data == ConnectivityResult.none) {
          return const Scaffold(
            body: Center(child: Text('Please check your internet connection')),
          );
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
