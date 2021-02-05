import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/data/models/tracker.dart';
import 'package:timetracker/data/repositories/tracker.dart';

class TrackerListController extends GetxController {
  final TrackerRepository _trackerRepository = Get.find<TrackerRepository>();

  RxList<Tracker> trackers = <Tracker>[].obs;

  Box box = Hive.box(BoxStorage.boxName);

  TrackerListController() {
    _load();
  }

  addItem(Tracker item) {
    _trackerRepository.insert(item).then((item) {
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
  }
}