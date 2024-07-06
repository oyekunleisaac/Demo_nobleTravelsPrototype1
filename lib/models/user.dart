import 'location.dart';

class Schedule {
  final Location location;
  final String payment;

  Schedule({required this.location, required this.payment});
}

class User {
  final String name;
  final String matricNumber;
  final String location;
  final int price;
  final DateTime timestamp;

  User({required this.name, required this.matricNumber, required this.location, required this.timestamp,required this.price});
}

class Location {
  final String name;

  Location({required this.name});
}
