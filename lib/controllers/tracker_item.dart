import 'package:get/get.dart';
import 'package:timetracker/data/models/action.dart';
import 'package:timetracker/data/models/tracker.dart';
import 'package:timetracker/data/repositories/action.dart';
import 'package:timetracker/data/repositories/tracker.dart';
import 'package:timetracker/utils.dart';

class TrackerItemController extends GetxController {
  final TrackerRepository _trackerRepository = Get.find<TrackerRepository>();
  final ActionRepository _actionRepository = Get.find<ActionRepository>();

  Rx<Tracker> _tracker;
  Rx<Duration> _time = Duration.zero.obs;
  RxBool _inProgress = false.obs;
  Stopwatch _stopwatch = Stopwatch();
  Duration _startTime;

  get timeFormated => durationString(_time.value);

  get tracker => _tracker.value;

  get inProgress => _inProgress.value;

  TrackerItemController(Tracker tracker) {
    this._tracker = tracker.obs;
    this._startTime = this._tracker.value.elapsedTime;

    if (this._tracker.value.inProgress) {
      play(save: false);
    }
    updateTimeValue();
  }

  updateTimeValue() {
    this._startTime = this._tracker.value.elapsedTime;
    _stopwatch.reset();

    if (this._tracker.value.inProgress) {
      int elapsedTimeFromLastSave = DateTime.now().millisecondsSinceEpoch - _tracker.value.updated.millisecondsSinceEpoch;
      this._startTime += Duration(milliseconds: elapsedTimeFromLastSave);
    }
    this._time.value = this._startTime;
  }

  edit(Tracker item) {
    _trackerRepository.update(item);
    _tracker(item);
  }

  play({ bool save = true }) {
    _stopwatch.start();
    _inProgress.value = true;
    _updateTime();

    if (save) {
      _tracker.value.inProgress = _inProgress.value;
      _trackerRepository.update(_tracker.value);
      _actionRepository.insert(Action(_tracker.value.id, ActionState.start));
    }
  }

  stop() {
    _stopwatch.stop();
    _inProgress.value = false;

    _tracker.value.elapsedTime = _time.value;
    _tracker.value.inProgress = _inProgress.value;
    _trackerRepository.update(_tracker.value);
    _actionRepository.insert(Action(_tracker.value.id, ActionState.stop));
  }

  reset() {
    _stopwatch.stop();
    _stopwatch.reset();
    _inProgress.value = false;

    _time.value = Duration.zero;
    _startTime = _time.value;
    _tracker.value.elapsedTime = _time.value;
    _tracker.value.inProgress = _inProgress.value;
    _trackerRepository.update(_tracker.value);
  }

  _updateTime() {
    Future.delayed(
      Duration(seconds: 1),
      () {
        if (_inProgress.value) {
          _time.value = _startTime + _stopwatch.elapsed;
          _updateTime();
        }
      },
    );
  }
}
