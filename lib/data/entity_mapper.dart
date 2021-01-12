import 'package:get/get.dart';
import 'package:timetracker/data/models/action.dart';
import 'package:timetracker/data/models/tracker.dart';
import 'package:timetracker/data/tables/action.dart';
import 'package:timetracker/data/tables/tracker.dart';
import 'package:timetracker/utils.dart';

class EntityMapper extends GetxService {

  Action fromSqlMapToAction(Map<String, dynamic> map) {
    return Action(map[ActionTable.trackerId], enumFromString(ActionState.values, map[ActionTable.action]))
      ..created = DateTime.parse(map[ActionTable.created]);
  }

  Map<String, dynamic> toSqlMapFromAction(Action object) {
    return <String, dynamic>{
      ActionTable.trackerId: object.trackerId,
      ActionTable.action: object.action.toString(),
      ActionTable.created: object.created.toIso8601String(),
    };
  }

  Tracker fromSqlMapToTracker(Map<String, dynamic> map) {
    return Tracker(map[TrackerTable.name])
      ..id = map[TrackerTable.id]
      ..name = map[TrackerTable.name]
      ..description = map[TrackerTable.description]
      ..created = DateTime.parse(map[TrackerTable.created])
      ..updated = DateTime.parse(map[TrackerTable.updated]);
  }

  Map<String, dynamic> toSqlMapFromTracker(Tracker object) {
    var map = <String, dynamic>{
      TrackerTable.name: object.name,
      TrackerTable.description: object.description,
      TrackerTable.created: object.created.toIso8601String(),
      TrackerTable.updated: object.updated.toIso8601String(),
    };
    if (object.id != null) {
      map[TrackerTable.id] = object.id;
    }
    return map;
  }
}