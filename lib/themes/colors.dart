import 'package:flutter/material.dart';

Color firstColor = Color(0xFFB817E3);
Color secondColor = Color(0xFFB817E3).withOpacity(0.5);
Color thirdColor = Color(0xFFB817E3).withOpacity(0.2);

Color greyColor = Color(0xFFE6E6E6);
Color darkGreyColor = Color(0xFFB8B2CB);

final appTheme = ThemeData(
    primarySwatch: Colors.purple,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      subtitle1: TextStyle(fontSize: 12.0, fontFamily: 'Hind'),
    ));
