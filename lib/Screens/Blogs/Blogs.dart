import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:larvae_classification/Screens/Blogs/AddBlogs.dart';
import 'package:larvae_classification/Screens/Blogs/BlogsCard.dart';
import 'package:larvae_classification/Screens/MobileNavigationScreen.dart';
import 'package:larvae_classification/commonUtils/Colors.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddBlogs()),
      );
    },
    backgroundColor: floatingActionButtonColor,
    shape: const CircleBorder(), // Set the background color directly
    child: const Icon(
      Icons.add,
      color: Colors.white,
      size: 30,
    ),
  ),

      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> const  MobileNavigationScreen()));

            },
         
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 24,
                    color: Colors.black,
                  )),
        centerTitle: true,
        title:const  Text("Blogs"),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
  stream: FirebaseFirestore.instance.collection("Blogs posts").snapshots(),
  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) => BlogsCard(
          snap: snapshot.data!.docs[index].data(),
        ),
      );
    } else {
      // Show placeholder image if there's no data in the database
      return Center(
        child: Image.asset(
          'assets/images/nodata.png', // Replace 'placeholder_image.png' with the path to your placeholder image asset
          width: 200,
          height: 200,
        ),
      );
    }
  },
),
    );
  }
}
