import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sugar_balance/blocs/filtered_reads/filtered_reads_bloc.dart';
import 'package:sugar_balance/blocs/home_page_bloc.dart';
import 'package:sugar_balance/blocs/reads/reads.dart';
import 'package:sugar_balance/blocs/simple_bloc_delegate.dart';
import 'package:sugar_balance/models/dao/reads_repository_simple.dart';
import 'package:sugar_balance/models/models.dart';
import 'package:sugar_balance/screens/add_edit_screen.dart';
import 'package:sugar_balance/themes/colors.dart';

import 'localizations/localization.dart';
import 'navigation/keys.dart';
import 'navigation/routes.dart';
import 'screens/home_screen.dart';

void main() {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    BlocProvider(
      builder: (context) {
        return ReadsBloc(
          todosRepository: const ReadsRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..dispatch(LoadReads());
      },
      child: SuggarBlanceApp(),
    ),
  );
}

class SuggarBlanceApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final readsBloc = BlocProvider.of<ReadsBloc>(context);
    final homePageBloc = HomePageBloc();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sugar Spice',
      theme: appTheme,
      localizationsDelegates: [SugarBalanceLocalizationsDelegate()],
      routes: {
        Routes.home: (context) {
          return BlocProviderTree(blocProviders: [
            BlocProvider<FilteredReadsBloc>(
              builder: (context) => FilteredReadsBloc(
                readsBloc: readsBloc,
                homePageBloc: homePageBloc,
              ),
            ),
          ], child: MyHomePage(homePageBloc: homePageBloc));
        },
        Routes.addReading: (context) {
          return AddEditScreen(
            key: Keys.addReadingScreen,
            onSave: (value, date, time, meal, periodOfMeal, note) {
              readsBloc.dispatch(
                AddRead(
                    Reading(value, date, time, meal, periodOfMeal, note: note)),
              );
            },
            isEditing: false,
          );
        },
      },
    );
  }
}
