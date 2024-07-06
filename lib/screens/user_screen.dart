import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_data.dart';
import '../models/user.dart' as UserModel;
import 'schedules_screen.dart';
import 'notification.dart';
import 'admin_screen.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String? _selectedLocation;
  String _userName = '';
  String _matricNumber = '';
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  final Map<String, int> _locationPrices = {
    'Ikeja ICM': 7000,
    'Redemption Camp': 5000,
    'Abuja': 10000,
    'Port Harcourt': 12000,
    'Jos': 11000,
  };

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _cardNumber = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Expiry Date (MM/YY)',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _expiryDate = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'CVV',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _cvv = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _confirmPayment();
              },
              child: Text('Pay'),
            ),
          ],
        );
      },
    );
  }

  void _confirmPayment() {
    final int price = _locationPrices[_selectedLocation!] ?? 0;
    UserModel.User newUser = UserModel.User(
      name: _userName,
      matricNumber: _matricNumber,
      location: _selectedLocation!,
      price: price,
      timestamp: DateTime.now(),
    );

    final userData = Provider.of<UserData>(context, listen: false);
    userData.addUser(newUser);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Confirmation'),
          content: Text('Amount: ₦$price\nPayment Successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SchedulesScreen()),
                );
              },
              child: Text('View Schedules'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noble Travels'),
      ),
      body: _selectedIndex == 0
          ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/banner.jpg'), // Adjust the path to your banner image
                  fit: BoxFit.cover,
                ),
              ),
              height: 200,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: DropdownButton<String>(
                hint: Text('Select Location'),
                value: _selectedLocation,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                },
                items: _locationPrices.keys.map((String location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) {
                  setState(() {
                    _userName = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Matric Number',
                ),
                onChanged: (value) {
                  setState(() {
                    _matricNumber = value;
                  });
                },
              ),
            ),
            if (_selectedLocation != null)
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selected Location:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text(_selectedLocation!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _showPaymentDialog,
                        child: Text('Pay'),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminScreen()),
                );
              },
              child: Text('Go to Admin'),
            ),
          ],
        ),
      )
          : (_selectedIndex == 1 ? SchedulesScreen() : NotificationScreen()),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
