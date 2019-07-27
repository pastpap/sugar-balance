import 'package:flutter/material.dart';
import 'package:sugar_balance/screens/add_edit_screen.dart';
import 'package:sugar_balance/themes/colors.dart';

import 'navigation/keys.dart';
import 'navigation/routes.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sugar Spice',
      theme: appTheme,
      routes: {
        Routes.home: (context) {
          return MyHomePage();
        },
        Routes.addReading: (context) {
          return AddEditScreen(
            key: Keys.addReadingScreen,
            isEditing: false,
          );
        },
      },
    );
  }
}
