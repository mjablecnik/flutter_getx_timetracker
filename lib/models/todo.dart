import 'package:timetracker/constants.dart';
import 'package:hive/hive.dart';

import 'folder.dart';
import 'item.dart';

part 'todo.g.dart';

@HiveType(typeId: 3)
class TodoList extends Item {

  @HiveField(50)
  List<TodoItem> items = [];

  TodoList(name, {List<String> path, DateTime created, DateTime lastChange})
      : super(name, path: path, created: created, lastChange: lastChange);

  factory TodoList.create(name, { List<String> path }) {
    var note = TodoList(name, path: path);
    note.save();
    return note;
  }

  save() {
    var box = Hive.box<TodoList>(ItemType.todo.toString());
    return box.put(Item.getKey(name, path), this);
  }
}

@HiveType(typeId: 4)
class TodoItem {

  @HiveField(0)
  String name;

  @HiveField(1)
  String checked;

  TodoItem(this.name, this.checked);
}
