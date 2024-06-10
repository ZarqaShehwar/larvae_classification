import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Provider/UserData.dart';
import 'package:larvae_classification/Screens/Blogs/Blogs.dart';
import 'package:larvae_classification/Screens/HomeScreen.dart';
import 'package:larvae_classification/Screens/ProfileScreen.dart';
import 'package:larvae_classification/Screens/Results.dart';
import 'package:provider/provider.dart';

class MobileNavigationScreen extends StatefulWidget {
  final int? page;

  const MobileNavigationScreen({this.page, super.key});

  @override
  State<MobileNavigationScreen> createState() => _MobileNavigationScreenState();
}

class _MobileNavigationScreenState extends State<MobileNavigationScreen> {
  int? _page;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    addData();
    _page = widget.page ?? 0; // Initialize _page inside initState
    pageController = PageController(initialPage: _page!);
  }

  Future<void> addData() async {
    UserData userData = Provider.of(context, listen: false);
    await userData.refreshUser();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationChange(int page) {
    pageController.jumpToPage(page);
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
 return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: const [
            HomeScreen(),
            Blogs(),
            MySavedResultsPage(),
            ProfleScreen()
          ],
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? Colors.red : Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.article_outlined,
                color: _page == 1 ? Colors.red : Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.leaderboard,
                color: _page == 2 ? Colors.red : Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 3 ? Colors.red : Colors.black,
              ),
            ),
          ],
          onTap: navigationChange,
        ),
      ),
    );
  }
}
