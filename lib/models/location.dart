class Location {
  final String name;
  Location(this.name);
}

class Schedule {
  final Location location;
  final String payment;
  Schedule(this.location, this.payment);
}

class User {
  final String name;
  final List<Schedule> schedules;
  User(this.name, this.schedules);
}
