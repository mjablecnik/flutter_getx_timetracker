import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timetracker/constants.dart';

import 'jottings.dart';
import 'basic.dart';

class DialogController extends GetxController {

  JottingsController _controller;
  TextEditingController dialogInput;

  onInit() {
    super.onInit();

    _controller = Get.find<JottingsController>();
    dialogInput = TextEditingController();
    print("Create dialogController");
  }

  onClose() {
    super.onClose();
    dialogInput.dispose();
    print("Dispose dialogController");
  }

  dialogInputConfirm([ItemType type]) {
    _controller.addItem(dialogInput.text, type);
    clearText();
    Get.back();
  }

  clearText() => dialogInput.text = "";

  open([ItemType type]) {
    Get.defaultDialog(
      onConfirm: () => dialogInputConfirm(type),
      onCancel: clearText,
      textCancel: "Cancel",
      textConfirm: "Confirm",
      content: TextField(
        controller: dialogInput,
        onSubmitted: (_) => dialogInputConfirm(type),
      ),
    );
  }
}
