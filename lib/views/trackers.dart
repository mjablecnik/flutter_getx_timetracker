import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timetracker/controllers/tracker.dart';
import 'package:timetracker/controllers/trackers.dart';
import 'package:timetracker/models/tracker.dart';

import 'dialog.dart';

class TrackersView extends GetView<TrackerListController> {
  @override
  Widget build(context) {
    return Scaffold(
      body: TrackerReorderList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TrackerDialog(
                title: "Add new tracker",
                onSubmit: (item) => controller.addItem(item),
              );
            },
          )
        },
      ),
    );
  }
}

class TrackerReorderList extends GetView<TrackerListController> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: Get.find<ScrollController>(),
      slivers: <Widget>[
        Obx(
          () => ReorderableSliverList(
            delegate: ReorderableSliverChildListDelegate([
              for (Tracker tracker in controller.trackers) TrackerItem(tracker),
            ]),
            onReorder: controller.reorder,
          ),
        )
      ],
    );
  }
}

class TrackerItem extends GetView<TrackerItemController> {

  final Tracker object;

  TrackerItem(this.object) {
    //controller.setupTracker(object);
  }

  @override
  Widget build(BuildContext context) {

    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.19,
      child: buildItemTile(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () => {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return TrackerDialog(
                  title: "Edit tracker",
                  //tracker: controller.tracker.value,
                  tracker: object,
                  onSubmit: (item) => controller.edit(item),
                );
              },
            )
          },
        ),
        IconSlideAction(
          caption: 'Remove',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            //Get.find<TrackerListController>().removeItem(controller.tracker.value);
            Get.find<TrackerListController>().removeItem(object);
          },
        ),
      ],
    );
  }

  Container buildItemTile() {
    return Container(
      height: 100,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Row(
            children: [
              Expanded(
                //child: buildTextInfo(controller.tracker.value)
                child: buildTextInfo(object)
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

  ListTile buildTextInfo(Tracker object) {
    var title = Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        object.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );

    var subtitle = Text(
      object.description,
      style: TextStyle(fontSize: 13),
    );

    if (object.description.isBlank) {
      return ListTile(
        title: title,
      );
    } else {
      return ListTile(
        title: title,
        subtitle: subtitle,
      );
    }
  }
}