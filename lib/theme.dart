import 'package:flutter/material.dart';

abstract class ColorDictionary {
  static const Map<String, Color> stringToColor = {
    'indigo': Colors.indigo,
    'green': Colors.green,
    'amber': Colors.amber,
    'blue': Colors.blue,
    'white': Colors.white,
    'black': Colors.black,
    'blueGrey': Colors.blueGrey,
    'lightBlue': Colors.lightBlue,
    'brown': Colors.brown,
    'teal': Colors.teal,
    'indigoAccent': Colors.indigoAccent,
    'grey': Colors.grey
  };
}

const double kCardBorderRadius = 8;
const Color kBlue = Colors.blue;
const Color antidoteLightBlue = Color(0xff4AB9C9);
const Color antidoteDarkBlue = Color(0xff2792BA);
final theme = _buildTheme();

ThemeData _buildTheme() {
  var base = ThemeData.light();
  print('font size of theme: ${base.primaryTextTheme.title.fontSize}');

  return base.copyWith(
    primaryColor: antidoteDarkBlue,
    accentColor: antidoteLightBlue,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: base.appBarTheme.copyWith(
      brightness: Brightness.light,
      iconTheme: base.iconTheme.copyWith(color: Colors.black),
      color: Colors.white,
      textTheme: base.primaryTextTheme.copyWith(
        title: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ).apply(
          color: Colors.black,
        ),
      ),
    ),
    cardTheme: base.cardTheme.copyWith(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardBorderRadius)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: antidoteDarkBlue,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
