import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Provider/UserData.dart';
import 'package:larvae_classification/Screens/Blogs/Blogs.dart';
import 'package:larvae_classification/Screens/HomeScreen.dart';
import 'package:larvae_classification/Screens/ProfileScreen.dart';
import 'package:larvae_classification/Screens/Results.dart';
import 'package:provider/provider.dart';

class MobileNavigationScreen extends StatefulWidget {
 final  int? page;
const MobileNavigationScreen({this.page, super.key});

  @override
  State<MobileNavigationScreen> createState() => Screen();
}

class Screen extends State<MobileNavigationScreen> {
  int? _page;
  late PageController pageController;
  NavigationChange(int page) {
    pageController.jumpToPage(page);
  }
   
  
   @override
  void initState() {
    super.initState();
    addData();
    _page = widget.page ?? 0; // Initialize _page inside initState
      pageController = PageController(initialPage: _page!);
  }

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
addData() async{
    UserData userData = Provider.of(context,listen:false);
    await userData.refreshUser();
    
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
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: const [HomeScreen(), Blogs(), ProfleScreen(),MySavedResultsPage()],
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              Icons.home,
              color: _page == 0 ? Colors.red : Colors.black,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.article_outlined,
              color: _page == 1 ? Colors.red : Colors.black,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.person,
              color: _page == 2 ? Colors.red : Colors.black,
            )),
             BottomNavigationBarItem(
                icon: Icon(
              Icons.leaderboard,
              color: _page == 3 ? Colors.red : Colors.black,
            )),
          ],
          onTap: NavigationChange,
        ));
  }
}
