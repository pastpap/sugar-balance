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

// Reads
  static final readList = const Key('__readList__');
  static final readsLoading = const Key('__readsLoading__');
  static final readItem = (String id) => Key('ReadItem__${id}');
  static final readItemValue = (String id) => Key('ReadItem__${id}__Value');
  static final readItemNote = (String id) => Key('ReadItem__${id}__Note');

  // Tabs
  static final tabs = const Key('__tabs__');
  static final readTab = const Key('__readTab__');
  static final statsTab = const Key('__statsTab__');

  // Extra Actions
  static final extraActionsButton = const Key('__extraActionsButton__');
  static final toggleAll = const Key('__markAllDone__');
  static final clearCompleted = const Key('__clearCompleted__');

  // Filters
  static final filterButton = const Key('__filterButton__');
  static final allFilter = const Key('__allFilter__');
  static final activeFilter = const Key('__activeFilter__');
  static final completedFilter = const Key('__completedFilter__');

  // Stats
  static final statsCounter = const Key('__statsCounter__');
  static final statsLoading = const Key('__statsLoading__');
  static final statsNumActive = const Key('__statsActiveItems__');
  static final statsNumCompleted = const Key('__statsCompletedItems__');

  // Details Screen
  static final editReadFab = const Key('__editReadFab__');
  static final deleteReadButton = const Key('__deleteReadFab__');
  static final readDetailsScreen = const Key('__readDetailsScreen__');
  static final detailsReadItemCheckbox = Key('DetailsRead__Checkbox');
  static final detailsReadItemTask = Key('DetailsRead__Task');
  static final detailsReadItemNote = Key('DetailsRead__Note');
}
