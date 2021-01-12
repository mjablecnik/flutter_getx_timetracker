import 'package:timetracker/constants.dart';
import 'package:timetracker/tables/action.dart';
import 'package:timetracker/tables/tracker.dart';
import 'package:timetracker/utils.dart';

class ActionModel {

  int trackerId;
  Action action;
  DateTime created = DateTime.now();


  ActionModel(this.trackerId, this.action);

  ActionModel.fromSqlMap(Map<String, dynamic> map) {
    trackerId = map[ActionTable.trackerId];
    action = enumFromString(Action.values, map[ActionTable.action]);
    created = DateTime.parse(map[TrackerTable.created]);
  }

  Map<String, dynamic> toSqlMap() {
    var map = <String, dynamic>{
      ActionTable.trackerId: trackerId,
      ActionTable.action: action.toString(),
      ActionTable.created: created.toIso8601String(),
    };
    return map;
  }

  @override
  String toString() {
    return "TrackerId: $trackerId; Action: $action; Created: $created;";
  }
}