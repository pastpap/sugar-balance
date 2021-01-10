import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sugar_balance/components/date_time_picker.dart';
import 'package:sugar_balance/localizations/localization.dart';
import 'package:sugar_balance/models/reading.dart';
import 'package:sugar_balance/navigation/keys.dart';

typedef OnSaveCallback = Function(String id, int task, DateTime date,
    TimeOfDay time, String meal, String periodOfMeal, String note);

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
  String _id;
  int _value;
  String _note;
  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  final List<String> _allMeals = <String>[
    'Breakfast',
    'Brunch',
    'Lunch',
    'Dinner',
    'Extra snack',
  ];
  final List<String> _allPeriods = <String>[
    'Before',
    'After',
  ];
  String get meal => widget.isEditing ? widget.reading.meal : 'Breakfast';
  String _meal;
  String _periodOfMeal;
  String get periodOfMeal =>
      widget.isEditing ? widget.reading.periodOfMeal : 'Before';

  bool get isEditing => widget.isEditing;
  bool _fromDateChanged = false;
  bool _fromTimeChanged = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = SugarBalanceLocalizations.of(context);
    _fromDate = decideDateValueBasedOnAction();
    _fromTime = decideTimeValueBasedOnAction();
    if (_meal == null) {
      _meal = meal;
    }
    if (_periodOfMeal == null) {
      _periodOfMeal = periodOfMeal;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editReading : localizations.addReading,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.reading.value.toString() : '0',
                key: Keys.valueField,
                keyboardType: TextInputType.number,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  labelText: "Blood sugar value",
                  hintText: "Add reading value", //localizations.newTodoHint,
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? localizations.emptyBloodLevel
                      : null;
                },
                onSaved: (value) => _value = int.parse(value),
              ),
              DateTimePicker(
                labelText: 'From',
                selectedDate: _fromDate,
                selectedTime: _fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    _fromDate = date;
                    _fromDateChanged = true;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    _fromTime = time;
                    _fromTimeChanged = true;
                  });
                },
              ),
              const SizedBox(height: 8.0),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Meal',
                  hintText: 'Choose a meal',
                  contentPadding: EdgeInsets.zero,
                ),
                isEmpty: _meal == null,
                child: Row(
                  children: <Widget>[
                    DropdownButton<String>(
                      value: _meal,
                      onChanged: (String newValue) {
                        setState(() {
                          _meal = newValue;
                        });
                      },
                      items: _allMeals
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    DropdownButton<String>(
                      value: _periodOfMeal,
                      onChanged: (String newPeriod) {
                        setState(() {
                          _periodOfMeal = newPeriod;
                        });
                      },
                      items: _allPeriods
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
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
            widget.onSave(_id, _value, _fromDate, _fromTime, _meal,
                _periodOfMeal, _note != null ? _note : '');
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  DateTime decideDateValueBasedOnAction() {
    if (isEditing) {
      if (_fromDateChanged) {
        return _fromDate;
      } else {
        return widget.reading.date;
      }
    } else {
      return _fromDate;
    }
  }

  TimeOfDay decideTimeValueBasedOnAction() {
    if (isEditing) {
      if (_fromTimeChanged) {
        return _fromTime;
      } else {
        return widget.reading.time;
      }
    } else {
      return _fromTime;
    }
  }
}
