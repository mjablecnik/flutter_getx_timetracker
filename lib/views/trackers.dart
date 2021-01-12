import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timetracker/controllers/tracker_item.dart';
import 'package:timetracker/controllers/tracker_list.dart';
import 'package:timetracker/data/models/tracker.dart';

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

class TrackerReorderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<TrackerListController>(
      builder: (c) {
        if (c.trackers.length > 0) {
          return ImplicitlyAnimatedReorderableList<Tracker>(
            items: c.trackers,
            areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
            onReorderFinished: (item, from, to, newItems) {
              c.reorder(from, to);
            },
            itemBuilder: (context, itemAnimation, item, index) {
              return Reorderable(
                key: ValueKey(item),
                builder: (context, dragAnimation, inDrag) {
                  return SizeFadeTransition(
                    sizeFraction: 0.5,
                    curve: Curves.easeIn,
                    animation: itemAnimation,
                    child: TrackerItem(TrackerItemController(item)),
                  );
                },
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class TrackerItem extends StatelessWidget {
  final controller;

  TrackerItem(this.controller);

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
                  tracker: controller.tracker.value,
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
          onTap: () => Get.find<TrackerListController>().removeItem(controller.tracker.value),
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
              Expanded(child: Obx(() => buildTextInfo(controller.tracker.value))),
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
                  children: [
                    Icon(Icons.play_arrow),
                    Handle(
                      delay: const Duration(milliseconds: 100),
                      child: Icon(Icons.drag_indicator),
                    ),
                  ],
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
