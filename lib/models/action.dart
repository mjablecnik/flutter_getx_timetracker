import 'package:timetracker/constants.dart';

class ActionModel {
  int trackerId;
  Action action;
  DateTime created = DateTime.now();

  ActionModel(this.trackerId, this.action);

  @override
  String toString() {
    return "TrackerId: $trackerId; Action: $action; Created: $created;";
  }
}
