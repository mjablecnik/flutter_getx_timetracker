import 'package:get/get.dart';
import 'package:timetracker/data/models/tracker.dart';
import 'package:timetracker/data/repositories/tracker.dart';
import 'package:timetracker/utils.dart';

class TrackerItemController extends GetxController {
  final TrackerRepository _trackerRepository = Get.find<TrackerRepository>();

  Rx<Tracker> _tracker;
  Rx<Duration> _time = Duration.zero.obs;
  RxBool _inProgress = false.obs;
  Stopwatch _stopwatch = Stopwatch();

  get timeFormated => durationString(_time.value);

  get tracker => _tracker.value;

  get inProgress => _inProgress.value;

  TrackerItemController(Tracker tracker) {
    this._tracker = tracker.obs;
  }

  edit(Tracker item) {
    _trackerRepository.update(item);
    _tracker(item);
  }

  play() {
    _stopwatch.start();
    _inProgress.value = true;
    _updateTime();
  }

  stop() {
    _stopwatch.stop();
    _inProgress.value = false;
  }

  _updateTime() {
    Future.delayed(
      Duration(seconds: 1),
      () {
        _time.value = _stopwatch.elapsed;
        if (_inProgress.value) {
          _updateTime();
        }
      },
    );
  }
}
