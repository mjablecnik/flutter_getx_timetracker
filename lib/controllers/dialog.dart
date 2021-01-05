import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class DialogController extends GetxController {

  TextEditingController dialogInput;
  final formKey = GlobalKey<FormState>();
  var model;

  void onInit() {
    super.onInit();

    dialogInput = TextEditingController();
    print("Create dialogController");
  }

  void onClose() {
    super.onClose();
    dialogInput.dispose();
    print("Dispose dialogController");
  }

  void submit(Function saveModel) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      saveModel.call();
      clearText();
      Get.back();
    }
  }

  void clearText() => dialogInput.text = "";

}
