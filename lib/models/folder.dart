import 'package:timetracker/constants.dart';
import 'package:hive/hive.dart';

import 'item.dart';

part 'folder.g.dart';

@HiveType(typeId: 1)
class Folder extends Item {

  @HiveField(50)
  List<Item> items = List<Item>();

  Folder(name, {List<String> path, DateTime created, DateTime lastChange})
      : super(name, path: path, created: created, lastChange: lastChange);


  factory Folder.create(name, { List<String> path }) {
    var item = Folder(name, path: path);
    item.save();
    return item;
  }

  save() {
    var box = Hive.box<Folder>(ItemType.folder.toString());
    var key = Item.getKey(name, path);
    box.put(key, this);
  }

  static Folder load(String name, List<String> path) {
    var box = Hive.box<Folder>(ItemType.folder.toString());
    var key = Item.getKey(name, path);
    return box.get(key);
  }
}
