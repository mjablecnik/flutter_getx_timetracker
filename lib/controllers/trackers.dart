import 'package:get/get.dart';
import 'package:timetracker/models/tracker.dart';
import 'package:timetracker/repositories/tracker.dart';

class TrackersController extends GetxController {
  TrackerRepository _trackerRepository;

  List<Tracker> trackers = <Tracker>[
  //  Tracker("Timetracker", description: "Programování timetrackeru."),
  //  Tracker("Rss feed", description: "Programování Rss feedu."),
  //  Tracker("Jottings", description: "Programování Jottings aplikace."),
  ].obs;


  TrackersController() {
    _trackerRepository = Get.find<TrackerRepository>();
    _load();
  }

  addItem(Tracker item) {
    trackers.add(item);
    _trackerRepository.insert(item);
  }

  reorder(int oldIndex, int newIndex) {
    var row = trackers.removeAt(oldIndex);
    trackers.insert(newIndex, row);
  }

  _load() async {
    trackers.addAll(await _trackerRepository.getAll());
  }
}
