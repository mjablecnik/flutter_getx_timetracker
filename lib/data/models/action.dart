
enum ActionState { start, stop }

class Action {
  int id;
  int trackerId;
  ActionState action;
  DateTime created = DateTime.now();

  Action(this.trackerId, this.action);

  @override
  String toString() {
    return "TrackerId: $trackerId; Action: $action; Created: $created;";
  }
}
