import 'package:duration/duration.dart';
import 'package:get/get.dart';
import 'package:timetracker/data/models/action.dart';
import 'package:timetracker/data/models/tracker.dart';
import 'package:timetracker/data/tables/action.dart';
import 'package:timetracker/data/tables/tracker.dart';
import 'package:timetracker/utils.dart';

class EntityMapper extends GetxService {

  Action fromSqlMapToAction(Map<String, dynamic> map) {
    return Action(map[ActionTable.trackerId], enumFromString(ActionState.values, map[ActionTable.action]))
      ..id = map[ActionTable.id]
      ..created = DateTime.parse(map[ActionTable.created]);
  }

  Map<String, dynamic> toSqlMapFromAction(Action object) {
    var map = <String, dynamic>{
      ActionTable.trackerId: object.trackerId,
      ActionTable.action: object.action.toString(),
      ActionTable.created: object.created.toIso8601String(),
    };
    if (object.id != null) {
      map[ActionTable.id] = object.id;
    }
    return map;
  }

  Tracker fromSqlMapToTracker(Map<String, dynamic> map) {
    return Tracker(map[TrackerTable.name])
      ..id = map[TrackerTable.id]
      ..name = map[TrackerTable.name]
      ..description = map[TrackerTable.description]
      ..created = DateTime.parse(map[TrackerTable.created])
      ..updated = DateTime.parse(map[TrackerTable.updated])
      ..elapsedTime = tryParseDuration(map[TrackerTable.elapsedTime]) ?? Duration.zero
      ..inProgress = (map[TrackerTable.inProgress] ?? 0) == 1 ? true : false
    ;
  }

  Map<String, dynamic> toSqlMapFromTracker(Tracker object) {
    var map = <String, dynamic>{
      TrackerTable.name: object.name,
      TrackerTable.description: object.description,
      TrackerTable.created: object.created.toIso8601String(),
      TrackerTable.updated: DateTime.now().toIso8601String(),
      TrackerTable.elapsedTime: prettyDuration(object.elapsedTime, abbreviated: true),
      TrackerTable.inProgress: object.inProgress ? 1 : 0,
    };
    if (object.id != null) {
      map[TrackerTable.id] = object.id;
    }
    return map;
  }
}