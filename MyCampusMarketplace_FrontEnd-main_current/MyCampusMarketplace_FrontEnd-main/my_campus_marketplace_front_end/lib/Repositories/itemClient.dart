import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycampusmarketplace/Models/item.dart';

// setting up item client....
// needs to be cleaned up more + commented...

const String apiAddress = "http://10.0.2.2/api/";

class ItemClient {
  Future<Item?> fetchItem(int itemId, String sessionState) async {
    try {
      var response = await http.get(
        Uri.parse('${apiAddress}fetchitem.php?id=$itemId'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success']) {
          var itemData = data['data'];
          return Item(
            itemId: itemData['ItemID'],
            itemName: itemData['ItemName'],
            itemDesc: itemData['ItemDesc'],
            itemCondition: itemData['ItemCondition'],
            //itemQuantity: itemData['ItemQuantity'] as int,
            itemPrice: double.tryParse(itemData['ItemPrice'] ?? '') ?? 0.0,
            itemWanted: itemData['ItemWanted'],
            //itemImage: itemData['itemImage'],
            userId: itemData['UserID'],
            itemAdded: DateTime.parse(itemData['ItemAdded']),
          );
        } else {
          return null;
        }
      } else if (response.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> postItem(
    String itemName,
    String itemDesc,
    String itemPrice,
    String itemCondition,
    String userID,
    String sessionState,
    // String itemImage,
    // int itemQuantity,
  ) async {
    try {
      var response = await http.post(
        Uri.parse('${apiAddress}postitem.php'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
        body: {
          'itemName': itemName,
          'itemDesc': itemDesc,
          'itemPrice': itemPrice,
          'itemCondition': itemCondition,
          'itemWanted': '0',
          'userID': userID,
          // 'itemImage': itemImage,
          // 'itemQuantity': itemQuantity,
        },
      );

      print('Session ID: $sessionState');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success']) {
          return "Success";
        } else {
          return data['data'];
        }
      } else {
        return "Server Error";
      }
    } catch (e) {
      print('Error: $e');
      return "An error occurred. Please try again later.";
    }
  }
}
