import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/controllers/dialog.dart';
import 'package:timetracker/controllers/jottings.dart';

class JottingsPage extends GetWidget<JottingsController> {
  @override
  Widget build(context) {
    var dialogController = Get.find<DialogController>();

    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => controller.goNext(controller.items[index]),
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(5),
                color: controller.getItemColor(controller.items[index].runtimeType),
                child: Center(
                  child: Text(controller.items[index].name),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: ButtonBar(
        buttonMinWidth: Get.width / 3.5,
        alignment: MainAxisAlignment.center,
        children: <RaisedButton>[
          RaisedButton(onPressed: () => dialogController.open(ItemType.note), child: Text("Add note")),
          RaisedButton(onPressed: () => dialogController.open(ItemType.todo), child: Text("Add todo")),
          RaisedButton(onPressed: () => dialogController.open(ItemType.folder), child: Text("Add folder")),
        ],
      ),
    );
  }
}
