import 'package:flutter/material.dart';
import 'package:sugarbalance/localizations/localization.dart';
import 'package:sugarbalance/models/models.dart';

class DeleteReadSnackBar extends SnackBar {
  final SugarBalanceLocalizations localizations;

  DeleteReadSnackBar({
    Key? key,
    required Reading reading,
    required VoidCallback onUndo,
    required this.localizations,
  }) : super(
          key: key,
          content: Text(
            localizations.readDeleted(reading.value.toString()),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: localizations.undo,
            onPressed: onUndo,
          ),
        );
}
