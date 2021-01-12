class Tracker {
  int id;
  String name;
  String description;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  Tracker(this.name, {this.description = ""});

  @override
  String toString() {
    return "Id: $id; Name: $name; Description: $description; Created: $created; Updated: $updated;";
  }
}
