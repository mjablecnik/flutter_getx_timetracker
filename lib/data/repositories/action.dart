import 'package:get/state_manager.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:timetracker/data/entity_mapper.dart';
import 'package:timetracker/data/models/action.dart';
import 'package:timetracker/data/tables/action.dart';

class ActionRepository extends GetxService {
  Database _db;
  EntityMapper _entityMapper;

  ActionRepository(this._db, this._entityMapper);

  Future<Action> insert(Action action) async {
    action.id = await _db.insert(ActionTable.tableName, _entityMapper.toSqlMapFromAction(action));
    return action;
  }

  Future<int> delete(int id) async {
    return await _db.delete(ActionTable.tableName, where: '${ActionTable.id} = ?', whereArgs: [id]);
  }

  Future<List<Action>> getAll(int trackerId) async {
    List<Map> rows = await _db.query(ActionTable.tableName, where: '${ActionTable.trackerId} = ?', whereArgs: [trackerId]);
    return [for (var row in rows) _entityMapper.fromSqlMapToAction(row)];
  }

  Future<Action> getLast() async {
    List<Map> rows = await _db.query(ActionTable.tableName, orderBy: ActionTable.created + " DESC", limit: 1);
    return _entityMapper.fromSqlMapToAction(rows.first);
  }
}
