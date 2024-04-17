import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Views/mainMenu.dart';
import 'package:mycampusmarketplace/Models/item.dart'; // Import Item model
import 'package:mycampusmarketplace/repositories/itemClient.dart'; // Import ItemClient

class ListItemPage extends StatefulWidget {
  @override
  _ListItemPageState createState() => _ListItemPageState();
}

class _ListItemPageState extends State<ListItemPage> {
  int _selectedConditionIndex = 0;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();

  // Create an instance of ItemClient
  ItemClient itemClient = ItemClient();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _itemDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List New Item'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Welcome, User'),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'myListings') {
                      // Navigate to My Listings screen
                    } else if (value == 'signOut') {
                      // Perform sign out
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Item Name'),
            TextField(
              controller: _itemNameController,
              decoration: InputDecoration(
                hintText: 'Enter item name',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Item Price'),
            TextField(
              controller: _itemPriceController,
              decoration: InputDecoration(
                hintText: 'Enter item price',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Condition'),
            DropdownButton<int>(
              value: _selectedConditionIndex,
              onChanged: (value) {
                setState(() {
                  _selectedConditionIndex = value!;
                });
              },
              items: <DropdownMenuItem<int>>[
                DropdownMenuItem(
                  value: 0,
                  child: Text('Select Condition'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('New'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('Used - Like New'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('Used - Good'),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text('Used - Fair'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Item Description'),
            TextField(
              controller: _itemDescriptionController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter item description',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Upload Photo'),
            // Add a button or widget to load a photo here
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement clear functionality
                    _itemNameController.clear();
                    _itemPriceController.clear();
                    _itemDescriptionController.clear();
                    setState(() {
                      _selectedConditionIndex = 0;
                    });
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // Perform validation
    if (_selectedConditionIndex == 0) {
      // Show error message or dialog for condition not selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a condition.'),
        ),
      );
      return;
    }

    // Continue with form submission
    String itemName = _itemNameController.text;
    String itemPrice = _itemPriceController.text;
    String itemDescription = _itemDescriptionController.text;
    String userId =
        ""; // Replace userId with the actual user ID from your application logic
    String selectedCondition;

    switch (_selectedConditionIndex) {
      case 1:
        selectedCondition = 'New';
        break;
      case 2:
        selectedCondition = 'Used - Like New';
        break;
      case 3:
        selectedCondition = 'Used - Good';
        break;
      case 4:
        selectedCondition = 'Used - Fair';
        break;
      default:
        selectedCondition = '';
    }

    // Example: Call postItem method from ItemClient
    itemClient
        .postItem(
      itemName,
      itemDescription,
      itemPrice,
      selectedCondition,
      userId,
    )
        .then((response) {
      // Handle the response here
      // For example, show a SnackBar with the response message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response),
        ),
      );
    }).catchError((error) {
      // Handle errors if any
      print(error);
    });
  }
}
