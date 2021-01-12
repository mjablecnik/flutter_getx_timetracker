import 'package:get/state_manager.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:timetracker/data/entity_mapper.dart';
import 'package:timetracker/models/tracker.dart';
import 'package:timetracker/tables/tracker.dart';

class TrackerRepository extends GetxService {
  Database _db;
  EntityMapper _entityMapper;

  TrackerRepository(this._db, this._entityMapper);

  Future<Tracker> insert(Tracker tracker) async {
    tracker.id = await _db.insert(TrackerTable.tableName, _entityMapper.toSqlMapFromTracker(tracker));
    return tracker;
  }

  Future<Tracker> update(Tracker tracker) async {
    tracker.id = await _db.update(
      TrackerTable.tableName,
      _entityMapper.toSqlMapFromTracker(tracker),
      where: '${TrackerTable.id} = ?',
      whereArgs: [tracker.id],
    );
    return tracker;
  }

  Future<int> delete(int id) async {
    return await _db.delete(TrackerTable.tableName, where: '${TrackerTable.id} = ?', whereArgs: [id]);
  }

  Future<Tracker> getById(int id) async {
    List<Map> maps = await _db.query(
      TrackerTable.tableName,
      where: '${TrackerTable.id} = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return _entityMapper.fromSqlMapToTracker(maps.first);
    }
    return null;
  }

  Future<List<Tracker>> getAll() async {
    List<Map> rows = await _db.query(TrackerTable.tableName);
    return [for (var row in rows) _entityMapper.fromSqlMapToTracker(row)];
  }
}
