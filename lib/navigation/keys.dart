import 'package:flutter/widgets.dart';

class Keys {
  // Home Screens
  static final homeScreen = const Key('__homeScreen__');
  static final addReading = const Key('__addReading__');
  static final snackbar = const Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Add Screen
  static final addReadingScreen = const Key('__addReadingScreen__');
  static final saveNewReading = const Key('__saveNewReading__');
  static final valueField = const Key('__valueField__');
  static final dateField = const Key('__dateField__');
  static final noteField = const Key('__noteField__');

  // Edit Screen
  static final editReadingScreen = const Key('__editReadingScreen__');
  static final saveReadingFab = const Key('__saveReadingFab__');
}
