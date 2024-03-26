import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Screens/Blogs/AddBlogs.dart';
import 'package:larvae_classification/Screens/Blogs/BlogsCard.dart';
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
        MaterialPageRoute(builder: (context) => AddBlogs()),
      );
    },
    backgroundColor: floatingActionButtonColor,
    shape: CircleBorder(), // Set the background color directly
    child: Icon(
      Icons.add,
      color: Colors.white,
      size: 30,
    ),
  ),

      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.logout_rounded)),
        centerTitle: true,
        title: Text("Blogs"),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Blogs posts").snapshots(),
          builder: ((context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) => BlogsCard(
                      snap: snapshot.data!.docs[index].data(),
                    )));
          })),
    );
  }
}
