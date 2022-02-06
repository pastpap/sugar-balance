import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sugarbalance/blocs/reads/reads.dart';
import 'package:sugarbalance/localizations/localization.dart';
import 'package:sugarbalance/navigation/flutter_read_keys.dart';
import 'package:sugarbalance/navigation/keys.dart';
import 'package:sugarbalance/screens/add_edit_screen.dart';

class DetailsScreen extends StatelessWidget {
  final formatter = new DateFormat('yyyy-MM-dd');
  final String id;

  DetailsScreen({Key? key, required this.id})
      : super(key: key ?? Keys.readDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final readsBloc = BlocProvider.of<ReadsBloc>(context);
    return BlocBuilder(
      bloc: readsBloc,
      builder: (context, dynamic state) {
        final read = (state as ReadsLoaded)
            .reads
            .firstWhereOrNull((read) => read.id == id);
        final localizations = SugarBalanceLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.readDetails),
            actions: [
              IconButton(
                tooltip: localizations.deleteRead,
                key: Keys.deleteReadButton,
                icon: Icon(Icons.delete),
                onPressed: () {
                  readsBloc.add(DeleteRead(read!));
                  Navigator.pop(context, read);
                },
              )
            ],
          ),
          body: read == null
              ? Container(key: FlutterReadsKeys.emptyDetailsContainer)
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${read.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      read.value.toString(),
                                      key: Keys.detailsReadItemTask,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      read.time.format(context),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      formatter.format(read.date),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    "Description",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    read.note,
                                    key: Keys.detailsReadItemNote,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: Keys.editReadFab,
            tooltip: localizations.editReading,
            child: Icon(Icons.edit),
            onPressed: read == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            key: Keys.editReadingScreen,
                            onSave: (id, value, fromDate, fromTime, meal,
                                periodOfMeal, note) {
                              readsBloc.add(
                                UpdateRead(
                                  read.copyWith(
                                      id: id,
                                      value: value,
                                      note: note,
                                      meal: meal,
                                      periodOfMeal: periodOfMeal,
                                      date: fromDate,
                                      time: fromTime),
                                ),
                              );
                            },
                            isEditing: true,
                            reading: read,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
