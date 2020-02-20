import 'dart:async';
import 'package:antidote/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:antidote/global.dart';
import '../global.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFetchingSharedPrefs = false;
  @override
  void initState() {
    super.initState();
    getEmail();
    setTimer();
  }

  getEmail() async {
    userEmail = await prefHandle.getValue('email');
  }

  setTimer() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, __, ___) => LoginScreen(),
        ),
      ),
    );
  }

  Future<bool> fetchSharedPreferences() {
    isFetchingSharedPrefs = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Hero(
            child: Image(
              height: 250,
              width: MediaQuery.of(context).size.width * 2,
              image: AssetImage(
                SplashScreenConfig.logoAssetName,
              ),
            ),
            tag: 'antidote-logo',
          ),
        ),
      ),
    );
  }
}
