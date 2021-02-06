import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:timetracker/controllers/tracker_list.dart';
import 'package:timetracker/data/models/tracker.dart';
import 'package:timetracker/views/tracker_item.dart';

class TrackerListView extends GetView<TrackerListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.trackers.length > 0) {
        return ImplicitlyAnimatedReorderableList<Tracker>(
          items: controller.trackers,
          areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
          onReorderFinished: (item, from, to, newItems) {
            controller.reorder(from, to);
          },
          itemBuilder: (context, itemAnimation, item, index) {
            return Reorderable(
              key: ValueKey(item),
              builder: (context, dragAnimation, inDrag) {
                return SizeFadeTransition(
                  sizeFraction: 0.5,
                  curve: Curves.easeIn,
                  animation: itemAnimation,
                  child: TrackerItem(item.controller),
                );
              },
            );
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
