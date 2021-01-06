import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timetracker/controllers/trackers.dart';
import 'package:timetracker/models/timetracker.dart';

import 'dialog.dart';

class TrackersView extends GetView<TrackersController> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: controller.trackers.length,
            itemBuilder: (context, index) {
              return TrackerItem(controller.trackers[index]);
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TrackerDialog();
            },
          )
        },
      ),
    );
  }
}

class TrackerItem extends GetView<TrackersController> {
  TimeTracker object;

  TrackerItem(this.object);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      object.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  subtitle: Text(
                    object.description,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "1:37:08",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonBar(
                  buttonPadding: const EdgeInsets.all(8.0),
                  children: [Icon(Icons.play_arrow), Icon(Icons.drag_indicator)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
