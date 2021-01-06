class TimeTracker {

  String name;
  String description = "";
  DateTime created = DateTime.now();
  DateTime lastChange = DateTime.now();

  TimeTracker(this.name, {this.description});
}