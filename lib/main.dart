import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/user_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'providers/user_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'Noble Travels',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginScreen(),
        routes: {
          '/admin': (ctx) => AdminScreen(),
          '/signup': (ctx) => SignupScreen(),
        },
      ),
    );
  }
}
