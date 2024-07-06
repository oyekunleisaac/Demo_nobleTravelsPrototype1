import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_data.dart';
import '../models/user.dart' as UserModel;

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    // UI design for the admin screen
    return Scaffold(
      appBar: AppBar(title: Text('Admin Screen')),
      body: ListView.builder(
        itemCount: userData.users.length,
        itemBuilder: (context, index) {
          final user = userData.users[index];
          return Card(
            child: ListTile(
              title: Text('${user.name} (${user.matricNumber})'),
              subtitle: Text('Location: ${user.location}\nAmount: ₦${user.price}'),
            ),
          );
        },
      ),
    );
  }
}
