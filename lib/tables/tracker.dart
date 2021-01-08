class TrackerTable {
  static const String tableName = "tracker";

  static const String id = "id";
  static const String name = "name";
  static const String description = "description";
  static const String created = "created";
  static const String updated = "updated";

  static const String createQuery = '''
      create table if not exists ${TrackerTable.tableName} ( 
        ${TrackerTable.id} integer primary key autoincrement, 
        ${TrackerTable.name} text not null,
        ${TrackerTable.description} text not null,
        ${TrackerTable.created} text not null,
        ${TrackerTable.updated} text not null);
      ''';
}
