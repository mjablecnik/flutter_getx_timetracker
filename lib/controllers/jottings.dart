import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/models/folder.dart';
import 'package:timetracker/models/item.dart';
import 'package:timetracker/models/note.dart';
import 'package:timetracker/models/todo.dart';
import 'package:timetracker/pages/jottings.dart';

class JottingsController extends GetxController {

  List<Item> items = <Item>[Note.create("testItem1"), Note.create("testItem2")].obs;
  Folder _currentFolder;


  onInit() {
    super.onInit();
    _currentFolder = Get.arguments;
    load();
  }

  addItem(String name, ItemType type) async {
    var item = Item.create(name, path: [..._currentFolder.path, _currentFolder.name], type: type);
    this.items.add(item);
    _currentFolder.items.add(item);
    _currentFolder.save();
  }

  removeItem(int index) {
    this.items.removeAt(index);
  }

  editItem() {

  }

  _loadRootFolder() {
    _currentFolder = Folder.load(rootFolderName, <String>[]);

    if (_currentFolder != null) {
      this.items.addAll(_currentFolder.items);
    } else {
      _currentFolder = Folder.create(rootFolderName, path: <String>[]);
    }
  }

  load() {
    if (_currentFolder == null) {
      _loadRootFolder();
    } else {
      _currentFolder = Folder.load(_currentFolder.name, _currentFolder.path);
    }
  }

  goNext(Item item) {
    if (item.runtimeType == Folder) {
      print("Going to next folder..");
      Get.to(JottingsPage(), arguments: item);
    }
  }

  getItemColor(Type item) {
    switch (item) {
      case Note:
        return Colors.blue;
        break;
      case TodoList:
        return Colors.green;
        break;
      case Folder:
        return Colors.black38;
        break;
      default:
        return Colors.red;
        break;
    }
  }
}