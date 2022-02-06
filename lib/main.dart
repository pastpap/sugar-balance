import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sugarbalance/blocs/filtered_reads/filtered_reads_bloc.dart';
import 'package:sugarbalance/blocs/home_page_bloc.dart';
import 'package:sugarbalance/blocs/reads/reads.dart';
import 'package:sugarbalance/blocs/simple_bloc_delegate.dart';
import 'package:sugarbalance/models/dao/reads_repository_simple.dart';
import 'package:sugarbalance/models/models.dart';
import 'package:sugarbalance/screens/add_edit_screen.dart';
import 'package:sugarbalance/themes/colors.dart';

import 'localizations/localization.dart';
import 'navigation/keys.dart';
import 'navigation/routes.dart';
import 'screens/home_screen.dart';

void main() {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) {
        return ReadsBloc(
          readsRepository: const ReadsRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(LoadReads());
      },
      child: SugarBalanceApp(),
    ),
  );
}

class SugarBalanceApp extends StatelessWidget {
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
          return MultiBlocProvider(providers: [
            BlocProvider<FilteredReadsBloc>(
              create: (context) => FilteredReadsBloc(
                readsBloc: readsBloc,
                homePageBloc: homePageBloc,
              ),
            ),
          ], child: MyHomePage(homePageBloc: homePageBloc));
        },
        Routes.addReading: (context) {
          return AddEditScreen(
            key: Keys.addReadingScreen,
            onSave: (id, value, date, time, meal, periodOfMeal, note) {
              readsBloc.add(
                AddRead(Reading(value, date, time, meal, periodOfMeal,
                    note: note, id: id)),
              );
            },
            isEditing: false,
          );
        },
      },
    );
  }
}
