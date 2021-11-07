import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sugar_balance/blocs/filtered_reads/filtered_reads.dart';
import 'package:sugar_balance/blocs/reads/reads.dart';
import 'package:sugar_balance/localizations/localization.dart';
import 'package:sugar_balance/navigation/flutter_read_keys.dart';
import 'package:sugar_balance/navigation/keys.dart';
import 'package:sugar_balance/screens/details_screen.dart';
import 'package:sugar_balance/widgets/delete_read_snack_bar.dart';
import 'package:sugar_balance/widgets/loading_indicator.dart';
import 'package:sugar_balance/widgets/read_item.dart';

class FilteredReads extends StatelessWidget {
  FilteredReads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final readsBloc = BlocProvider.of<ReadsBloc>(context);
    final filteredReadsBloc = BlocProvider.of<FilteredReadsBloc>(context);
    final localizations = SugarBalanceLocalizations.of(context);

    return BlocBuilder(
      bloc: filteredReadsBloc,
      builder: (context, dynamic state) {
        if (state is FilteredReadLoading) {
          return LoadingIndicator(key: Keys.readsLoading);
        } else if (state is FilteredReadLoaded) {
          final reads = state.filteredReads;
          return ListView.builder(
            shrinkWrap: true,
            key: Keys.readList,
            itemCount: reads.length,
            itemBuilder: (BuildContext context, int index) {
              final read = reads[index];
              return ReadItem(
                reading: read,
                onDismissed: (direction) {
                  readsBloc.add(DeleteRead(read));
                  ScaffoldMessenger.of(context).showSnackBar(DeleteReadSnackBar(
                    key: Keys.snackbar,
                    reading: read,
                    onUndo: () => readsBloc.add(AddRead(read)),
                    localizations: localizations!,
                  ));
                },
                onTap: () async {
                  final removedRead = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: read.id);
                    }),
                  );
                  if (removedRead != null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(DeleteReadSnackBar(
                      key: Keys.snackbar,
                      reading: read,
                      onUndo: () => readsBloc.add(AddRead(read)),
                      localizations: localizations!,
                    ));
                  }
                },
              );
            },
          );
        } else {
          return Container(key: FlutterReadsKeys.filteredReadsEmptyContainer);
        }
      },
    );
  }
}
