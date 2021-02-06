import 'package:flutter/widgets.dart' show WidgetsBindingObserver, WidgetsBinding, AppLifecycleState;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/controllers/tracker_item.dart';
import 'package:timetracker/data/models/tracker.dart';
import 'package:timetracker/data/repositories/tracker.dart';

class TrackerListController extends GetxController with WidgetsBindingObserver {
  final TrackerRepository _trackerRepository = Get.find<TrackerRepository>();

  RxList<Tracker> trackers = <Tracker>[].obs;

  Box box = Hive.box(BoxStorage.boxName);

  onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      for (Tracker tracker in trackers) {
        tracker.controller.updateTimeValue();
      }
    }
  }

  addItem(Tracker item) {
    _trackerRepository.insert(item).then((item) {
      item.controller = TrackerItemController(item);
      trackers.add(item);
      updateSequence();
    });
  }

  removeItem(Tracker item) {
    trackers.remove(item);
    _trackerRepository.delete(item.id);
    updateSequence();
  }

  reorder(int oldIndex, int newIndex) {
    var row = trackers.removeAt(oldIndex);
    trackers.insert(newIndex, row);
    updateSequence();
  }
  
  updateSequence() {
    var trackersIdList = trackers.map((e) => e.id).toList();
    box.put(BoxStorage.trackerSequence, trackersIdList);
  }

  _load() async {
    List<Tracker> trackerList = await _trackerRepository.getAll();
    List<dynamic> trackerSequence = box.get(BoxStorage.trackerSequence);

    if (trackerList.length == 0) {
      trackerList = <Tracker>[
        Tracker("Timetracker", description: "Programování timetrackeru."),
        Tracker("Rss feed", description: "Programování Rss feedu."),
        Tracker("Jottings", description: "Programování Jottings aplikace."),
      ];
      trackerList.forEach(_trackerRepository.insert);
    }

    if (trackerSequence == null) {
      trackerList.forEach(trackers.add);
    } else {
      for (int id in trackerSequence) {
        trackers.add(trackerList.firstWhere((e) => e.id == id));
      }
    }
    for (Tracker tracker in trackers) {
      tracker.controller = TrackerItemController(tracker);
    }
  }
}