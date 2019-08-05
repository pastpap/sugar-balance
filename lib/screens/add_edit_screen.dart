import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sugar_balance/components/date_time_picker.dart';
import 'package:sugar_balance/localizations/localization.dart';
import 'package:sugar_balance/models/Reading.dart';
import 'package:sugar_balance/navigation/keys.dart';

typedef OnSaveCallback = Function(
    int task, DateTime date, TimeOfDay time, String note);

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

  int _task;
  String _note;
  static DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime =
      TimeOfDay(hour: _fromDate.hour, minute: _fromDate.minute);

  final List<String> _allMeals = <String>[
    'Breakfast',
    'Brunch',
    'Lunch',
    'Dinner',
    'Extra snack'
  ];
  String _meal = 'Breakfast';

  bool get isEditing => widget.isEditing;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = SugarBalanceLocalizations.of(context);

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
                key: Keys.valueField,
                keyboardType: TextInputType.number,
                autofocus: !isEditing,
                style: textTheme.headline,
                decoration: InputDecoration(
                  labelText: "Blood sugar value",
                  hintText: "Add reading value", //localizations.newTodoHint,
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? localizations.emptyBloodLevel
                      : null;
                },
                onSaved: (value) => _task = int.parse(value),
              ),
              DateTimePicker(
                labelText: 'From',
                selectedDate: _fromDate,
                selectedTime: _fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    _fromDate = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    _fromTime = time;
                  });
                },
              ),
              const SizedBox(height: 8.0),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Meal',
                  hintText: 'Choose an meal',
                  contentPadding: EdgeInsets.zero,
                ),
                isEmpty: _meal == null,
                child: DropdownButton<String>(
                  value: _meal,
                  onChanged: (String newValue) {
                    setState(() {
                      _meal = newValue;
                    });
                  },
                  items:
                      _allMeals.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
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
        key: isEditing ? Keys.saveReadingFab : Keys.saveNewReading,
        tooltip:
            isEditing ? localizations.saveChanges : localizations.addReading,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_task, _fromDate, _fromTime, _note);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
