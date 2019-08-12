import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sugar_balance/localizations/localization.dart';
import 'package:sugar_balance/navigation/flutter_read_keys.dart';
import 'package:sugar_balance/navigation/keys.dart';
import 'package:sugar_balance/blocs/reads/reads.dart';
import 'package:sugar_balance/screens/add_edit_screen.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id})
      : super(key: key ?? Keys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final readsBloc = BlocProvider.of<ReadsBloc>(context);
    return BlocBuilder<ReadsBloc, ReadsState>(
      builder: (context, state) {
        final read = (state as ReadsLoaded)
            .reads
            .firstWhere((read) => read.id == id, orElse: () => null);
        final localizations = SugarBalanceLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.todoDetails),
            actions: [
              IconButton(
                tooltip: localizations.deleteTodo,
                key: Keys.deleteTodoButton,
                icon: Icon(Icons.delete),
                onPressed: () {
                  readsBloc.dispatch(DeleteRead(read));
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
                                      key: Keys.detailsTodoItemTask,
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    ),
                                  ),
                                ),
                                Text(
                                  read.note,
                                  key: Keys.detailsTodoItemNote,
                                  style: Theme.of(context).textTheme.subhead,
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
            key: Keys.editTodoFab,
            tooltip: localizations.editTodo,
            child: Icon(Icons.edit),
            onPressed: read == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            key: Keys.editReadingScreen,
                            onSave: (value, fromDate, fromTime, note) {
                              readsBloc.dispatch(
                                UpdateRead(
                                  read.copyWith(
                                      value: value,
                                      note: note,
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
