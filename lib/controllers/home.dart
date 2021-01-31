import 'package:get/get.dart';

class HomeController extends GetxController {

  var _index = 0.obs;
  var _prevIndex = 0;
  var _transitionPos = 1.obs;

  get index => _index.value;
  get transitionPos => _transitionPos.value;

  changeIndex(int index) {
    this._prevIndex = this.index;
    this._index.value = index;
    _transitionPos.value = this._prevIndex < this.index ? 1 : -1;
    this.update();
  }
}