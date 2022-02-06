import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class SugarBalanceLocalizations {
  SugarBalanceLocalizations(this.locale);

  final Locale locale;

  static Future<SugarBalanceLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return SugarBalanceLocalizations(locale);
    });
  }

  static SugarBalanceLocalizations? of(BuildContext context) {
    return Localizations.of<SugarBalanceLocalizations>(
        context, SugarBalanceLocalizations);
  }

  String get reads => Intl.message(
        'Reads',
        name: 'reads',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'Show All',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showActive => Intl.message(
        'Show Active',
        name: 'showActive',
        args: [],
        locale: locale.toString(),
      );

  String get showCompleted => Intl.message(
        'Show Completed',
        name: 'showCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get newReadHint => Intl.message(
        'What needs to be done?',
        name: 'newReadHint',
        args: [],
        locale: locale.toString(),
      );

  String get markAllComplete => Intl.message(
        'Mark all complete',
        name: 'markAllComplete',
        args: [],
        locale: locale.toString(),
      );

  String get markAllIncomplete => Intl.message(
        'Mark all incomplete',
        name: 'markAllIncomplete',
        args: [],
        locale: locale.toString(),
      );

  String get clearCompleted => Intl.message(
        'Clear completed',
        name: 'clearCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get addReading => Intl.message(
        'Add Blood Reading',
        name: 'addReading',
        args: [],
        locale: locale.toString(),
      );

  String get editReading => Intl.message(
        'Edit Blood Reading',
        name: 'editReading',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get filterReads => Intl.message(
        'Filter Reads',
        name: 'filterReads',
        args: [],
        locale: locale.toString(),
      );

  String get deleteRead => Intl.message(
        'Delete Read',
        name: 'deleteRead',
        args: [],
        locale: locale.toString(),
      );

  String get readDetails => Intl.message(
        'Read Details',
        name: 'readDetails',
        args: [],
        locale: locale.toString(),
      );

  String get emptyBloodLevel => Intl.message(
        'Please enter a number',
        name: 'emptyBloodLevel',
        args: [],
        locale: locale.toString(),
      );

  String get notesHint => Intl.message(
        'Additional Notes...',
        name: 'notesHint',
        args: [],
        locale: locale.toString(),
      );

  String readDeleted(String value) => Intl.message(
        'Deleted "$value"',
        name: 'readDeleted',
        args: [value],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String get deleteReadConfirmation => Intl.message(
        'Delete this reading?',
        name: 'deleteReadConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: locale.toString(),
      );
}

class SugarBalanceLocalizationsDelegate
    extends LocalizationsDelegate<SugarBalanceLocalizations> {
  @override
  Future<SugarBalanceLocalizations> load(Locale locale) =>
      SugarBalanceLocalizations.load(locale);

  @override
  bool shouldReload(SugarBalanceLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");
}
