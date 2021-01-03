import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'basic.dart';

class DialogController extends GetxController {

  BasicController _controller;
  TextEditingController dialogInput;

  onInit() {
    super.onInit();

    _controller = Get.find<BasicController>();
    dialogInput = TextEditingController();
    print("Create dialogController");
  }

  onClose() {
    super.onClose();
    dialogInput.dispose();
    print("Dispose dialogController");
  }

  dialogInputConfirm() {
    _controller.addItem(dialogInput.text);
    clearText();
    Get.back();
  }

  clearText() => dialogInput.text = "";

  open() {
    Get.defaultDialog(
      onConfirm: () => dialogInputConfirm(),
      onCancel: clearText,
      textCancel: "Cancel",
      textConfirm: "Confirm",
      content: TextField(
        controller: dialogInput,
        onSubmitted: (_) => dialogInputConfirm(),
      ),
    );
  }
}
