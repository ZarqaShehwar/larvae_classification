import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:larvae_classification/FirebaseServices/FirebaseServices.dart';
import 'package:larvae_classification/Provider/UserData.dart';
import 'package:larvae_classification/Screens/MobileNavigationScreen.dart';
import 'package:larvae_classification/Screens/ProfileScreenPages/ContactUs.dart';
import 'package:larvae_classification/Screens/ProfileScreenPages/FAQ.dart';
import 'package:larvae_classification/Screens/ProfileScreenPages/Help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:larvae_classification/Screens/Results.dart';
import 'package:larvae_classification/User/userModel.dart' as model;
import 'package:larvae_classification/commonUtils/Colors.dart';
import 'package:provider/provider.dart';

class ProfleScreen extends StatefulWidget {
  const ProfleScreen({super.key});

  @override
  State<ProfleScreen> createState() => _ProfleScreenState();
}

class _ProfleScreenState extends State<ProfleScreen> {
  final FirebaseAuth _auths = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User? _user;
  int _results = 0;
  int _detected = 0;
  double _accuracy = 0;

  FirebaseAuth auth = FirebaseAuth.instance;
  var userData = {};
  bool isLoading = false;

  final List<Map<String, dynamic>> data2 = [
    {"icon": Icons.leaderboard, "heading1": "Results", "heading2": "216"},
    {"icon": Icons.check, "heading1": "Accuracy", "heading2": "100%"},
    {"icon": Icons.verified_rounded, "heading1": "Detected", "heading2": "20"},
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Query<Map<String, dynamic>> resultsQuery = _firestore
        .collection("Predictions")
        .where('userId', isEqualTo: _auths.currentUser!.uid);

    Query<Map<String, dynamic>> detectedQuery = _firestore
        .collection("Predictions")
        .where('userId', isEqualTo: _auths.currentUser!.uid);

    QuerySnapshot<Map<String, dynamic>> resultsSnapshot =
        await resultsQuery.get();
    QuerySnapshot<Map<String, dynamic>> detectedSnapshot =
        await detectedQuery.get();

    int resultsCount = resultsSnapshot.docs.length;
    int detectedCount = detectedSnapshot.docs.length;
    double accuracy =
        resultsCount > 0 ? 60.0 : 0;

    setState(() {
      _results = resultsCount;
      _detected = detectedCount;
      _accuracy = accuracy;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model.UserDetail user =
        Provider.of<UserData>(context, listen: false).getUser;
    return isLoading
        ? const Center(child: CircularProgressIndicator(color: Colors.black))
        : Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MobileNavigationScreen()));
                  },
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 24,
                    color: Colors.white,
                  )),
            ),
            body: Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        redGradient,
                        purpleGradient,
                      ]),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: user.photoURL != null
                            ? NetworkImage(user.photoURL!)
                            : const AssetImage('assets/images/avatar.png')
                                as ImageProvider<Object>?,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        user.username ?? "Hello User",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 330,
                            height: 60,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: data2.length,
                              itemBuilder: (context, index) => SizedBox(
                                width: 100,
                                height: 60,
                                child: Column(
                                  children: [
                                    Icon(
                                      index == 0
                                          ? Icons.leaderboard
                                          : index == 1
                                              ? Icons.check
                                              : Icons.verified_rounded,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      index == 0
                                          ? "Results"
                                          : index == 1
                                              ? "Accuracy"
                                              : "Detected",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      index == 0
                                          ? '$_results'
                                          : index == 1
                                              ? '$_accuracy%'
                                              : '$_detected',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const VerticalDivider(
                                color: Colors
                                    .grey, // Customize the color as needed
                                thickness:
                                    1, // Customize the thickness as needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: CustomColumn(
                      data: [
                        {
                          "icon": Icons.favorite_rounded,
                          "title": "My Saved",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () =>Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MySavedResultsPage()),
                              ),
                        },
                        {
                          "icon": Icons.contact_mail,
                          "title": "Contact us",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () =>Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ContactUs()),
                              ),
                        },
                        {
                          "icon": Icons.question_answer,
                          "title": "FAQ",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => FAQ()),
                              ),
                        },
                        {
                          "icon": Icons.help,
                          "title": "Help",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Help()),
                              ),
                        },
                        {
                          "icon": Icons.exit_to_app,
                          "title": "Log Out",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () async =>
                              {FirebaseServices().signOut(context)},
                        },
                        // Add more items as needed
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}

class CustomColumn extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CustomColumn({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var item in data)
          Padding(
            padding:
                const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 4),
            child: InkWell(
              onTap: item["onClick"],
              child: ListTile(
                leading: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: <Color>[
                          Colors.black,
                          Colors.red,
                        ],
                      ).createShader(bounds);
                    },
                    child: Icon(item["icon"] as IconData, size: 20)),
                title: Text(
                  item["title"] as String,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
                trailing: Icon(
                  item["rightIcon"] as IconData,
                  size: 28,
                  color: Colors.grey,
                ),
              ),
            ),
          )
      ],
    );
  }
}
