import 'package:get/state_manager.dart';
import 'package:timetracker/models/tracker.dart';
import 'package:timetracker/tables/tracker.dart';

class TrackerRepository extends GetxService {
  var db;

  TrackerRepository(this.db);

  Future<Tracker> insert(Tracker tracker) async {
    tracker.id = await db.insert(TrackerTable.tableName, tracker.toSqlMap());
    return tracker;
  }

  Future<Tracker> update(Tracker tracker) async {
    tracker.id = await db.update(
      TrackerTable.tableName,
      tracker.toSqlMap(),
      where: '${TrackerTable.id} = ?',
      whereArgs: [tracker.id],
    );
    return tracker;
  }

  Future<int> delete(int id) async {
    return await db.delete(TrackerTable.tableName, where: '${TrackerTable.id} = ?', whereArgs: [id]);
  }

  Future<Tracker> getById(int id) async {
    List<Map> maps = await db.query(
      TrackerTable.tableName,
      where: '${TrackerTable.id} = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return Tracker.fromSqlMap(maps.first);
    }
    return null;
  }

  Future<List<Tracker>> getAll() async {
    List<Map> rows = await db.query(TrackerTable.tableName);
    return [for (var row in rows) Tracker.fromSqlMap(row)];
  }
}
