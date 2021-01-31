import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:timetracker/controllers/tracker_item.dart';
import 'package:timetracker/controllers/tracker_list.dart';
import 'package:timetracker/data/models/tracker.dart';
import 'package:timetracker/views/tracker_item.dart';

import 'dialog.dart';

class TrackerListView extends GetView<TrackerListController> {
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

