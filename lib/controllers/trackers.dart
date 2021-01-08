import 'package:get/get.dart';
import 'package:timetracker/models/tracker.dart';

class TrackersController extends GetxController {
  var count = 0.obs;
  List<Tracker> trackers = <Tracker>[
    Tracker("Timetracker", description: "Programování timetrackeru."),
    Tracker("Rss feed", description: "Programování Rss feedu."),
    Tracker("Jottings", description: "Programování Jottings aplikace."),
  ].obs;

  increment() => count++;

  addItem(Tracker item) {
    trackers.add(item);
  }

  reorder(int oldIndex, int newIndex) {
    var row = trackers.removeAt(oldIndex);
    trackers.insert(newIndex, row);
  }
}
