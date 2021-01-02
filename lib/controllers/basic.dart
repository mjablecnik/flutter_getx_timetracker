import 'package:get/get.dart';

class BasicController extends GetxController {
  var count = 0.obs;
  List<String> simpleList = <String>["test1", "test2"].obs;

  increment() => count++;

  addItem(String item, type) {
    simpleList.add(item);
  }
}