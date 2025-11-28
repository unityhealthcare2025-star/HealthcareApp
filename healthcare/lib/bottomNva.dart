import 'package:flutter/material.dart';
import 'package:healthcare/MyProfile.dart';
import 'package:healthcare/api/viewProfileapi.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:healthcare/homePage.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

class Bottomnav extends StatefulWidget {
   Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> with TickerProviderStateMixin {
  late MotionTabBarController _tabController;

  final GlobalKey<ProfileScreenState> profileKey =
      GlobalKey<ProfileScreenState>();

  late List<Widget> _screens = [
    Homepage(),
    ProfileScreen(key: profileKey),
  ];

  @override
  void initState() {
    super.initState();

    // NOW length = 2
    _tabController = MotionTabBarController(
      initialIndex: 0,
      length: _screens.length,
      vsync: this,
    );

    
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

        onTabItemSelected: (index) {
          setState(() {
            _tabController.index = index;

            if (index == 1) {
              profileKey.currentState?.fetchProfile();
            }
          });
        },
      ),
    );
  }
}
