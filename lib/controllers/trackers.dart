import 'package:get/get.dart';
import 'package:timetracker/models/tracker.dart';
import 'package:timetracker/repositories/tracker.dart';

class TrackerListController extends GetxController {
  TrackerRepository _trackerRepository;

  RxList<Tracker> trackers = <Tracker>[].obs;


  TrackerListController() {
    _trackerRepository = Get.find<TrackerRepository>();
    _load();
  }

  addItem(Tracker item) {
    trackers.add(item);
    _trackerRepository.insert(item);
  }

  removeItem(Tracker item) {
    trackers.remove(item);
    _trackerRepository.delete(item.id);
  }

  reorder(int oldIndex, int newIndex) {
    var row = trackers.removeAt(oldIndex);
    trackers.insert(newIndex, row);
  }

  _load() async {
    _trackerRepository.getAll().then((List<Tracker> trackerList) {
      if (trackerList.length == 0) {
        trackerList = <Tracker>[
          Tracker("Timetracker", description: "Programování timetrackeru."),
          Tracker("Rss feed", description: "Programování Rss feedu."),
          Tracker("Jottings", description: "Programování Jottings aplikace."),
        ];
        trackerList.forEach(_trackerRepository.insert);
      }
      trackerList.forEach(trackers.add);
    });
  }
}
