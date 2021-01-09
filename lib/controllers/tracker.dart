import 'package:get/get.dart';
import 'package:timetracker/models/tracker.dart';
import 'package:timetracker/repositories/tracker.dart';

class TrackerItemController extends GetxController {
  TrackerRepository _trackerRepository;

  Rx<Tracker> tracker;


  TrackerItemController(Tracker tracker) {
    _trackerRepository = Get.find<TrackerRepository>();
    this.tracker = tracker.obs;
  }

  edit(Tracker item) {
    _trackerRepository.update(item);
    tracker(item);
  }
}
