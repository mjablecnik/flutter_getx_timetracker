import 'package:get/get.dart';
import 'package:timetracker/models/timetracker.dart';

class TrackersController extends GetxController {
  var count = 0.obs;
  List<TimeTracker> trackers = <TimeTracker>[
    TimeTracker("Timetracker", description: "Programování timetrackeru."),
    TimeTracker("Rss feed", description: "Programování Rss feedu."),
    TimeTracker("Jottings", description: "Programování Jottings aplikace."),
  ].obs;

  increment() => count++;

  addItem(TimeTracker item) {
    trackers.add(item);
  }
}
