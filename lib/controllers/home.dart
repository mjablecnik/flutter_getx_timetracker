import 'package:get/get.dart';

class HomeController extends GetxController {
  var index = 0.obs;

  changeIndex(int index) {
    this.index = RxInt(index);
    this.update();
  }
}