import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sugarbalance/models/models.dart';
import 'package:sugarbalance/navigation/keys.dart';

class ReadItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Reading reading;

  ReadItem({
    Key? key,
    required this.onDismissed,
    required this.onTap,
    required this.reading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Keys.readItem(reading.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Hero(
          tag: '${reading.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              reading.value.toString(),
              key: Keys.readItemValue(reading.id),
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              reading.time.format(context),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            if (reading.note.isNotEmpty)
              Text(
                reading.note,
                key: Keys.readItemNote(reading.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              )
            else
              Text(''),
          ],
        ),
      ),
    );
  }
}
