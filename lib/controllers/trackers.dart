import 'package:get/get.dart';
import 'package:timetracker/models/timetracker.dart';

class TrackersController extends GetxController {
  var count = 0.obs;
  List<TimeTracker> trackers = <TimeTracker>[TimeTracker("test1"), TimeTracker("test2")].obs;

  increment() => count++;

  addItem(TimeTracker item) {
    trackers.add(item);
  }
}