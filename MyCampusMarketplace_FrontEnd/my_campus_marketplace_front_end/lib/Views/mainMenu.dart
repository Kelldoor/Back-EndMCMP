import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/main.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState(userName);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState(userName);
  late String userName = widget.userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Campus Marketplace')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Welcome, $userName'),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'myListings') {
                      // Navigate to My Listings screen
                    } else if (value == 'signOut') {
                      _logout();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'myListings',
                      child: Text('My Listings'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'signOut',
                      child: Text('Sign Out'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to List New Item screen
              },
              child: Text('List New Item'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to For Sale screen
              },
              child: const Text('For Sale'),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    // Calling the logout function
    String logoutResponse = await client.logout();

    if (logoutResponse == "Success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginSignupPage()),
      );
    } else {
      _showErrorDialog(logoutResponse);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(userName: "User"),
  ));
}
