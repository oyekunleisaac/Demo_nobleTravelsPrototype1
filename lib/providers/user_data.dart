import 'package:flutter/material.dart';
import '../models/location.dart' as LocationModel;
import '../models/user.dart' as UserModel;

class UserData extends ChangeNotifier {
  List<UserModel.User> _users = [];

  List<UserModel.User> get users => _users;

  void addUser(UserModel.User user) {
    _users.add(user);
    notifyListeners();
  }

  void updateUser(UserModel.User newUser) {
    // Update user logic
    notifyListeners();
  }

  void deleteUser(UserModel.User user) {
    _users.remove(user);
    notifyListeners();
  }
}
