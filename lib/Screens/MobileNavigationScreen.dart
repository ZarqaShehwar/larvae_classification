import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Screens/Blogs/Blogs.dart';
import 'package:larvae_classification/Screens/HomeScreen.dart';
import 'package:larvae_classification/Screens/ProfileScreen.dart';
import 'package:provider/provider.dart';

class MobileNavigationScreen extends StatefulWidget {
  const MobileNavigationScreen({super.key});

  @override
  State<MobileNavigationScreen> createState() => Screen();
}

class Screen extends State<MobileNavigationScreen> {
  int _page = 0;
  late PageController pageController;
  NavigationChange(int page) {
    pageController.jumpToPage(page);
  }

  OnPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
    
 body: PageView(
  
  controller: pageController,
  onPageChanged: OnPageChanged,
   children: const [
  HomeScreen(), // Display the Home Page
  Blogs(),
  ProfleScreen() // Display the Search Page
    // Other pages...
  ],
),
bottomNavigationBar: CupertinoTabBar(
          backgroundColor:Colors.transparent,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              Icons.home,
              color: _page == 0 ? Colors.red : Colors.black,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.article_outlined,
              color: _page == 1 ? Colors.red  : Colors.black,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.person,
              color: _page == 2 ? Colors.red  : Colors.black,
            )),
          ],
          onTap: NavigationChange,
        ));
  
 }
}