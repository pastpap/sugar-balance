import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sugar_balance/models/Reading.dart';
import 'package:sugar_balance/navigation/keys.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Reading reading;

  AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.reading,
  }) : super(key: key ?? Keys.addReadingScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    //final localizations = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          //  isEditing ? localizations.editTodo : localizations.addTodo,
          isEditing ? "Edit Read" : "Add Read",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.reading.value : '0',
                key: Keys.noteField,
                keyboardType: TextInputType.datetime,
                autofocus: !isEditing,
                style: textTheme.headline,
                decoration: InputDecoration(
                  hintText: "Add reading value", //localizations.newTodoHint,
                ),
                /*validator: (val) {
                  return val.trim().isEmpty
                      ? localizations.emptyTodoError
                      : null;
                },*/
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.reading.note : '',
                key: Keys.noteField,
                maxLines: 10,
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText:
                      "Add description of meal before reading", //localizations.notesHint,
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /*key:
            isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        tooltip: isEditing ? localizations.saveChanges : localizations.addTodo,*/
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_task, _note);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
