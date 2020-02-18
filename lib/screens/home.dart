import 'package:antidote/screens/dashboard.dart';
import 'package:antidote/screens/explore.dart';
import 'package:antidote/screens/forum.dart';
import 'package:antidote/screens/messages.dart';
import 'package:antidote/screens/profile.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedScreen = 0;
  List<Widget> _screens;
  @override
  void initState() {
    _screens = [
      Dashboard(),
      Explore(),
      Forum(),
      Messages(),
      Profile(),
    ];
    super.initState();
    _tabController = TabController(vsync: this, length: _screens.length);
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreen,
        onTap: (int index) {
          setState(() {
            _selectedScreen = index;
            _tabController.animateTo(_selectedScreen);
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image(
              image: AppImages.logoWithTitle,
              height: 40,
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
              icon: Column(
                children: <Widget>[
                  Image(image: AppImages.explore, height: 26),
                  SizedBox(
                    height: 2,
                  ),
                  Image(image: AppImages.exploreText, height: 10),
                ],
              ),
              title: Text(""),
              activeIcon: Column(
                children: <Widget>[
                  Image(
                      image: AppImages.explore,
                      color: AppColors.blue,
                      height: 26),
                  SizedBox(
                    height: 2,
                  ),
                  Image(
                      image: AppImages.exploreText,
                      color: AppColors.blue,
                      height: 10),
                ],
              )),
          BottomNavigationBarItem(
            icon: Image(
              image: AppImages.forum,
              height: 40,
            ),
            title: Text(""),
            activeIcon: Image(
              image: AppImages.forum,
              height: 40,
              color: AppColors.blue,
            ),
          ),
          BottomNavigationBarItem(
              icon: Column(
                children: <Widget>[
                  Image(
                    image: AppImages.chat,
                    height: 26,
                  ),
                  Image(
                    image: AppImages.chat_text,
                    height: 10,
                  ),
                ],
              ),
              title: Text(""),
              activeIcon: Column(
                children: <Widget>[
                  Image(
                    image: AppImages.chat,
                    height: 26,
                    color: AppColors.blue,
                  ),
                  Image(
                    image: AppImages.chat_text,
                    height: 10,
                    color: AppColors.blue,
                  ),
                ],
              )),
          BottomNavigationBarItem(
            icon: Column(
              children: <Widget>[
                Image(
                  image: AppImages.profile,
                  height: 26,
                ),
                Image(
                  image: AppImages.profileText,
                  height: 10,
                ),
              ],
            ),
            title: Text(""),
            activeIcon: Column(
              children: <Widget>[
                Image(
                  image: AppImages.profile,
                  height: 26,
                  color: AppColors.blue,
                ),
                Image(
                  image: AppImages.profileText,
                  height: 10,
                  color: AppColors.blue,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SafeArea workInProg() {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'Work in progress (UI Changes/DB Connectivity)',
          ),
        ),
      ),
    );
  }
}
