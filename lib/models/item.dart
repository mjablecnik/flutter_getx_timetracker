class Item {

  String name;
  String description = "";
  DateTime created = DateTime.now();
  DateTime lastChange = DateTime.now();

  Item(this.name);
}