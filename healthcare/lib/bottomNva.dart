import 'package:flutter/material.dart';
import 'package:healthcare/MyProfile.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:healthcare/ViewProfile.dart';
import 'package:healthcare/homePage.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> with TickerProviderStateMixin {
  late MotionTabBarController _tabController;

  final List<Widget> _screens = [
    Homepage(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabBarController(
      initialIndex: 0,
      length: _screens.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _screens,
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _tabController,
        labels: const ["Home", "Profile"],
        icons: const [Icons.home, Icons.person],
        initialSelectedTab: "Home",
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.grey,
        tabSelectedColor: Colors.blueAccent,
        tabIconSize: 28.0,
        tabBarColor: Colors.white,
        onTabItemSelected: (int index) {
          setState(() {
            _tabController.index = index;
          });
        },
      ),
    );
  }
}
