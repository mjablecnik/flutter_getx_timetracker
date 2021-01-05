import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timetracker/controllers/trackers.dart';

class TrackersView extends GetView<TrackersController> {
  @override
  Widget build(context) {

    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: controller.trackers.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            margin: const EdgeInsets.all(5),
            color: Colors.amber[600],
            child: Center(
              child: Text(controller.trackers[index].name),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () { print("Not implemented adding new trackers."); },
      ),
    );
  }
}
