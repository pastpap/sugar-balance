import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  static m0(task) => "Deleted \"${task}\"";

  final Map<String, dynamic> messages =
      _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => {
        "activeReads": MessageLookupByLibrary.simpleMessage("Active Reads"),
        "addReading": MessageLookupByLibrary.simpleMessage("Add Reading"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "clearCompleted":
            MessageLookupByLibrary.simpleMessage("Clear completed"),
        "completedReads":
            MessageLookupByLibrary.simpleMessage("Completed Reads"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteRead": MessageLookupByLibrary.simpleMessage("Delete Read"),
        "deleteReadConfirmation":
            MessageLookupByLibrary.simpleMessage("Delete this reading?"),
        "editReading": MessageLookupByLibrary.simpleMessage("Edit Reading"),
        "emptyBloodLevel":
            MessageLookupByLibrary.simpleMessage("Please enter a number"),
        "filterReads": MessageLookupByLibrary.simpleMessage("Filter Reads"),
        "markAllComplete":
            MessageLookupByLibrary.simpleMessage("Mark all complete"),
        "markAllIncomplete":
            MessageLookupByLibrary.simpleMessage("Mark all incomplete"),
        "newReadHint":
            MessageLookupByLibrary.simpleMessage("What needs to be done?"),
        "notesHint":
            MessageLookupByLibrary.simpleMessage("Additional Notes..."),
        "saveChanges": MessageLookupByLibrary.simpleMessage("Save changes"),
        "showActive": MessageLookupByLibrary.simpleMessage("Show Active"),
        "showAll": MessageLookupByLibrary.simpleMessage("Show All"),
        "showCompleted": MessageLookupByLibrary.simpleMessage("Show Completed"),
        "stats": MessageLookupByLibrary.simpleMessage("Stats"),
        "readDeleted": m0,
        "readDetails": MessageLookupByLibrary.simpleMessage("Read Details"),
        "reads": MessageLookupByLibrary.simpleMessage("Reads"),
        "undo": MessageLookupByLibrary.simpleMessage("Undo")
      };
}
