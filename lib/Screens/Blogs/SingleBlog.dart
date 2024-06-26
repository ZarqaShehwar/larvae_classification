import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:larvae_classification/FirebaseServices/FireStore.dart';
import 'package:larvae_classification/Screens/Blogs/BlogsCard.dart';
import 'package:larvae_classification/Screens/MobileNavigationScreen.dart';

class SingleBlog extends StatelessWidget {
  final String? photoUrl;
  final String? title;
  final String? postId;
  final String? description;

  const SingleBlog(
      {this.photoUrl, this.postId, this.title, this.description, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BlogsCard()));
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 24,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Blogs",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
             await FirestoreMethods().delete(postId!, context);
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.delete,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(photoUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  description ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
