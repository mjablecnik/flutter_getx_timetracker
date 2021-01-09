import 'package:get/get.dart';
import 'package:timetracker/models/tracker.dart';
import 'package:timetracker/repositories/tracker.dart';

class TrackerItemController extends GetxController {
  TrackerRepository _trackerRepository;

  Rx<Tracker> tracker;


  TrackerItemController() {
    _trackerRepository = Get.find<TrackerRepository>();
  }

  edit(Tracker item) {
    _trackerRepository.update(item);
    tracker(item);
    update();
  }

  void setupTracker(Tracker object) {
    tracker = object.obs;
    print(tracker);
  }
}
