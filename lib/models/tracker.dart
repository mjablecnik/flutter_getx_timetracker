class Tracker {

  String name;
  String description = "";
  DateTime created = DateTime.now();
  DateTime lastChange = DateTime.now();

  Tracker(this.name, {this.description});
}