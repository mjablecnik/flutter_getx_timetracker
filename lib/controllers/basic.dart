import 'package:get/get.dart';
import 'package:timetracker/models/item.dart';

class BasicController extends GetxController {
  var count = 0.obs;
  List<Item> simpleList = <Item>[Item("test1"), Item("test2")].obs;

  increment() => count++;

  addItem(String item) {
    simpleList.add(Item(item));
  }
}