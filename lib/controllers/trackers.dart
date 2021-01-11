import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/models/tracker.dart';
import 'package:timetracker/repositories/tracker.dart';

class TrackerListController extends GetxController {
  TrackerRepository _trackerRepository;

  RxList<Tracker> trackers = <Tracker>[].obs;

  final box = GetStorage();

  TrackerListController() {
    _trackerRepository = Get.find<TrackerRepository>();
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
    box.write(BoxStorage.trackerSequence, trackers.map((e) => e.id).toList());
  }

  _load() async {
    List<Tracker> trackerList = await _trackerRepository.getAll();
    List<dynamic> trackerSequence = box.read(BoxStorage.trackerSequence);

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