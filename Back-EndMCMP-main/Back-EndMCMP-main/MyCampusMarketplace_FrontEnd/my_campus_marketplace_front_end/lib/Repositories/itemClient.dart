import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mycampusmarketplace/Models/item.dart';

const String apiAddress = "http://10.0.2.2/api/";

class ItemClient {
  String sessionState = "";
  String errorMessage = "";

  Future<String> postItem(Item item) async {
    try {
      var response = await http.post(
        // Sending item post request to server
        Uri.parse('${apiAddress}postitem.php'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
        body: {
          'itemName': item.itemName,
          'itemDesc': item.itemDesc,
          'itemCondition': item.itemCondition,
          'itemPrice': item.itemPrice,
          'itemQuantity': item.itemQuantity,
          'itemWanted': item.itemWanted ? '1' : '0',
          'userID': item.userID.toString(),
        },
      );

      // Parse data response
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success'] && data['reason'] == 200) {
          return "Success";
        } else {
          return data['data'];
        }
      } else {
        return "An error occurred. Please try again later.";
      }
    } catch (e) {
      return "An error occurred. Please try again later.";
    }
  }

  // Other methods to be added at some point.
  // No testing has been done with this API call, just some "hold" code for now.
}
