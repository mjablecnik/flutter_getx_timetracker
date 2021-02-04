class Tracker {
  int id;
  String name;
  String description;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();
  Duration elapsedTime = Duration.zero;
  bool inProgress = false;

  Tracker(this.name, {this.description = ""});

  @override
  String toString() {
    return "Id: $id; Name: $name; Description: $description; Created: $created; Updated: $updated; ElapsedTime: $elapsedTime; InProgress: $inProgress";
  }
}
