import 'package:timetracker/tables/tracker.dart';

class Tracker {

  int id;
  String name;
  String description;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();


  Tracker(this.name, {this.description = ""});

  Tracker.fromSqlMap(Map<String, dynamic> map) {
    id = map[TrackerTable.id];
    name = map[TrackerTable.name];
    description = map[TrackerTable.description];
    created = DateTime.parse(map[TrackerTable.created]);
    updated = DateTime.parse(map[TrackerTable.updated]);
  }


  Map<String, dynamic> toSqlMap() {
    var map = <String, dynamic>{
      TrackerTable.name: name,
      TrackerTable.description: description,
      TrackerTable.created: created.toIso8601String(),
      TrackerTable.updated: updated.toIso8601String(),
    };
    if (id != null) {
      map[TrackerTable.id] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Id: $id; Name: $name; Description: $description; Created: $created; Updated: $updated;";
  }
}