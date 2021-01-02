import 'package:timetracker/constants.dart';
import 'package:hive/hive.dart';

import 'item.dart';
import 'folder.dart';

part 'note.g.dart';

@HiveType(typeId: 2)
class Note extends Item {

  @HiveField(50)
  String content = "";

  Note(name, {List<String> path, DateTime created, DateTime lastChange})
      : super(name, path: path, created: created, lastChange: lastChange);

  factory Note.create(name, { List<String> path }) {
    var note = Note(name, path: path);
    note.save();
    return note;
  }

  save() {
    var box = Hive.box<Note>(ItemType.note.toString());
    return box.put(Item.getKey(name, path), this);
  }
}
