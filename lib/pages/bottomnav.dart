import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quest_bank/pages/bookmark.dart';
import 'package:quest_bank/pages/home.dart';
import 'package:quest_bank/pages/profile.dart';

class BottomNav extends StatefulWidget {
  final int initialTabIndex;

  const BottomNav({Key? key, this.initialTabIndex = 0}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int currentTabIndex;

  @override
  void initState() {
    super.initState();
    currentTabIndex = widget.initialTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: MediaQuery.of(context).size.height / 16,
        color: Color(0Xff0c9cc8),
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(Icons.home_filled, color: Colors.white, size: 30),
          Icon(Icons.bookmark_rounded, color: Colors.white, size: 30),
          Icon(Icons.person_4_rounded, color: Colors.white, size: 30),
        ],
      ),
      body: IndexedStack(
        index: currentTabIndex,
        children: [
          HomePage(),
          BookMark(showBackButton: false),
          Profile(showBackButton: false),
        ],
      ),
    );
  }
}
