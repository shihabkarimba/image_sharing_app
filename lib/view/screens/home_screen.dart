import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_sharing_app/view/screens/add_image_screen.dart';
import 'package:image_sharing_app/view/screens/profile_info_screen.dart';
import 'package:image_sharing_app/view/style/colors.dart';
import 'package:image_sharing_app/view/widgets/design.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchWallpapersFuture;
  List<DocumentSnapshot> _wallpapers = [];
  bool _dataFetched = false;

  Future<void> _fetchWallpapers() async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('wallpaper')
          .orderBy('createdAt', descending: true)
          .get();

      setState(() {
        _wallpapers = data.docs;
        _dataFetched = true; // Set the flag to indicate data has been fetched
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle the error gracefully, e.g., show an error message.
    }
  }
   Widget _buildWallpaperItem(DocumentSnapshot wallpaperSnapshot) {
    final imageUrl = wallpaperSnapshot['image'] as String;

    return GestureDetector(
      onTap: () {
        // Handle tapping on a wallpaper item
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20), // Add padding as needed
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover, // You can adjust the fit as needed
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    if (!_dataFetched) {
      // Only fetch data if it hasn't been fetched before
      _fetchWallpapersFuture = _fetchWallpapers();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileInfoScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset('assets/image/account.png'),
            ),
          )
        ],
      ),
      floatingActionButton:FloatingActionButton(
        backgroundColor: yelloColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddImageScreen()),
          );
        },
        child: const Icon(Icons.camera_enhance),
      ),
      body: Stack(
        children: [
          const PinkDesign(),
          FutureBuilder<void>(
            future: _fetchWallpapersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                // Handle the error gracefully, e.g., show an error message.
                return Center(
                  child: Text('Error loading data: ${snapshot.error}'),
                );
              } else {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return _buildWallpaperItem(_wallpapers[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20,);
                  },
                  itemCount: _wallpapers.length,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
