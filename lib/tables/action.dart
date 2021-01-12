import 'package:timetracker/tables/tracker.dart';

class ActionTable {
  static const String tableName = "action";

  static const String trackerId = "tracker_id";
  static const String created = "created";
  static const String action = "action";

  static const String createQuery = '''
      create table if not exists ${ActionTable.tableName} ( 
        ${ActionTable.trackerId} integer not null, 
        ${ActionTable.created} text not null,
        ${ActionTable.action} text not null,
        FOREIGN KEY(${ActionTable.trackerId}) REFERENCES ${TrackerTable.tableName}(${TrackerTable.id})
        );
      ''';
}
