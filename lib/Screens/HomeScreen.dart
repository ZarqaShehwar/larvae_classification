import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Screens/Blogs/Blogs.dart';
import 'package:larvae_classification/Screens/PictureScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:larvae_classification/Screens/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? selectedImage;
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          unselectedFontSize: 16,
          selectedFontSize: 16,
          items: [
            BottomNavigationBarItem(
                icon:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Blogs()));
                    },
                    icon: const Icon(Icons.article_outlined)),
                label: 'Blogs'),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfleScreen()));
                    },
                    icon: const Icon(Icons.person)),
                label: 'Profile'),
          ]),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 350,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xffB81736),
                      Color(0xff281537),
                    ]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 20),
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 50,
                    //   height: 50,
                    //   child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(100),
                    //       child: const Image(
                    //         image: AssetImage(
                    //             'assets/images/img_licensed_image_4.png'),
                    //       )),
                    // ),
                    SizedBox(width: 20),
                    const Text(
                      "Larvae Classification ",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 130, left: 27),
                child: Container(
                    child: Card(
                        elevation: 8,
                        shadowColor: Colors.grey,
                        child: Container(
                            width: 300,
                            height: 170,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Early Protection For You &\n Your Family Health",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      width: 130,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xffB81736),
                                          Color(0xff281537),
                                        ]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Learn more",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )),
                                    )
                                  ],
                                ))))),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(
                  top: 360, left: 10, right: 10, bottom: 10),
              child: Card(
                elevation: 8,
                shadowColor: Colors.grey,
                child: Container(
                  width: 400,
                  height: 350,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () => pickImageFromCamera(),
                              child: Card(
                                  elevation: 8,
                                  shadowColor: Colors.black,
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ShaderMask(
                                            blendMode: BlendMode.srcIn,
                                            shaderCallback: (Rect bounds) {
                                              return const LinearGradient(
                                                colors: <Color>[
                                                  Colors.black,
                                                  Colors.red,
                                                ],
                                              ).createShader(bounds);
                                            },
                                            child: const Icon(
                                                Icons.camera_alt_outlined,
                                                size: 22)),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'Camera',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () => pickImage(),
                            child: Card(
                              elevation: 8,
                              shadowColor: Colors.black,
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return const LinearGradient(
                                            colors: <Color>[
                                              Colors.black,
                                              Colors.red,
                                            ],
                                          ).createShader(bounds);
                                        },
                                        child: Icon(Icons.image, size: 22)),
                                    SizedBox(height: 4),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            child: Card(
                                elevation: 8,
                                shadowColor: Colors.black,
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ShaderMask(
                                          blendMode: BlendMode.srcIn,
                                          shaderCallback: (Rect bounds) {
                                            return const LinearGradient(
                                              colors: <Color>[
                                                Colors.black,
                                                Colors.red,
                                              ],
                                            ).createShader(bounds);
                                          },
                                          child: Icon(Icons.leaderboard,
                                              size: 22)),
                                      SizedBox(height: 4),
                                      Text(
                                        'Results',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Health Article",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    colors: <Color>[
                                      Colors.black,
                                      Colors.red,
                                    ],
                                  ).createShader(bounds);
                                },
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 20, top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img_image_16.png'),
                                        fit: BoxFit.fill)),
                              ),
                              Container(
                                  child: Text(
                                "The 25 Healthiest Fruits you can Eat,\nAccording to a Nutritionist",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ))
                            ],
                          ))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Future pickImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(returnImage!.path);
    if (returnImage != null) {
      setState(() {
        selectedImage = File(returnImage.path);
        image = selectedImage!.readAsBytesSync();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PictureScreen(image: image, selectedImage: selectedImage)));
      });
    } else
      return;
  }

  Future pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage != null) {
      setState(() {
        selectedImage = File(returnImage.path);
        image = selectedImage!.readAsBytesSync();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PictureScreen(image: image, selectedImage: selectedImage)));
      });
    } else
      return;
  }
}
