import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routeName.dart';
import '../../controls/dashboard_control.dart';
import '../dashboard/home_screen.dart';
import 'activity_trackerScreen.dart';
import './profileScreen.dart';
import '../../template/misc/colors.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);
  final _dashBoardScreenC = Get.find<DashBoardControl>();

  final List<Widget> listRouteName = [
    const HomeScreen(),
    const ActivityTrackerScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => listRouteName[_dashBoardScreenC.tabIndex.value]),
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[200]!],
          ),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(dashBoardScreenC: _dashBoardScreenC),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key, required this.dashBoardScreenC}) : super(key: key);
  final DashBoardControl dashBoardScreenC;
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<IconData> _iconList = [
    Icons.home_outlined,
    Icons.local_activity_outlined,
    // Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: _iconList,
      activeIndex: widget.dashBoardScreenC.tabIndex.value,
      onTap: (index) {
        setState(() {
          widget.dashBoardScreenC.tabIndex.value = index;
        });
      },
      notchSmoothness: NotchSmoothness.smoothEdge,
      blurEffect: true,
      activeColor: Colors.purple.withOpacity(0.5),
      gapLocation: GapLocation.center,
    );
  }
}
