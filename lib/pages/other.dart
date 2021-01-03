import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timetracker/controllers/basic.dart';
import 'package:timetracker/controllers/dialog.dart';

class Other extends GetView<BasicController> {
  @override
  Widget build(context) {

    var dialogController = Get.find<DialogController>();

    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: controller.simpleList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                margin: const EdgeInsets.all(5),
                color: Colors.amber[600],
                child: Center(
                  child: Text(controller.simpleList[index].name),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: dialogController.open,
      ),
    );
  }
}
