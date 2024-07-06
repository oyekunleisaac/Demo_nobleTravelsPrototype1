import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_data.dart';

class SchedulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedules'),
      ),
      body: ListView.builder(
        itemCount: userData.users.length,
        itemBuilder: (context, index) {
          final user = userData.users[index];
          return ListTile(
            title: Text('${user.name} - ${user.location}'),
            subtitle: Text(
                'Matric: ${user.matricNumber}, Price: ₦${user.price}\nBooked at: ${user.timestamp}'),
          );
        },
      ),
    );
  }
}
