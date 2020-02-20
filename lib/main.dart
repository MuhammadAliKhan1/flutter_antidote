import 'package:antidote/helpers/locator.dart';
import 'package:antidote/helpers/navigation_service.dart';
import 'package:antidote/models/inherited/user_therapist.dart';
import 'package:flutter/material.dart';
import 'package:antidote/theme.dart';
import 'package:flutter/services.dart';
import 'global.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/splash.dart';

void main() {
  setupLocator();
  runApp(
    AntidoteApp(),
  );
}

class AntidoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return UTData(
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Antidote',
        theme: theme,
        navigatorKey: locator<NavigationService>().navigatorKey,
        initialRoute: 'splash',
        onGenerateRoute: (routeSettings) {
          switch (routeSettings.name) {
            case RouteNames.splashScreen:
              return MaterialPageRoute(builder: (context) => SplashScreen());
            case RouteNames.loginScreen:
              return MaterialPageRoute(builder: (context) => LoginScreen());
            case RouteNames.signUpScreen:
              return MaterialPageRoute(builder: (context) => SignupScreen());
            case RouteNames.homeScreen:
              return MaterialPageRoute(builder: (context) => Home());
            default:
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: Center(
                    child: Text('No path for ${routeSettings.name}'),
                  ),
                ),
              );
          }
        },
      ), therapistData: null, userData: null,
    );
  }
}
