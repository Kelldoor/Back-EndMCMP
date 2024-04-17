import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycampusmarketplace/Models/item.dart';

const String apiAddress = "http://10.0.2.2/api/";


class ItemClient {
  String sessionState = "";


  Future<Item?> fetchItem(int itemId) async {
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
              itemPrice: double.parse(itemData['ItemPrice']),
              itemWanted: itemData['ItemWanted'],
              userId: itemData['UserID'],
              itemAdded: DateTime.parse(itemData['ItemAdded']));
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
      },
    );

    print('Post Item API response: ${response.statusCode}');

    var data = json.decode(response.body);
    print('Post Item API data: $data');

    if (response.statusCode == 200) {
      if (data['success']) {
        print('Item posted successfully.');
        return "Success";
      } else {
        print('Item post failed. Reason: ${data['data']}');
        return data['data'];
      }
    } else {
      print('Server Error: ${data['data']}');
      return "Server Error";
    }
  } catch (e) {
    print('An error occurred: $e');
    return "An error occurred. Please try again later.";
  }
 }



  Future<Map<String, dynamic>> listPosts({
    bool conditionNew = false,
    bool conditionFair = false,
    bool conditionGood = false,
    bool conditionLikeNew = false,
    double minPrice = 0,
    double maxPrice = double.infinity,
    int size = 100,
    int start = 0,
    String? user,
    String? userBy,
    String order = '-Items.ItemAdded',
  }) async {
    try {
      var queryParams = {
        'condition_new': conditionNew ? '1' : '',
        'condition_fair': conditionFair ? '1' : '',
        'condition_good': conditionGood ? '1' : '',
        'condition_likenew': conditionLikeNew ? '1' : '',
        'minprice': minPrice.toString(),
        'maxprice': maxPrice.toString(),
        'size': size.toString(),
        'start': start.toString(),
        if (user != null) 'user': user,
        if (userBy != null) 'userby': userBy,
        'order': order,
      };


      var uri = Uri.https(apiAddress, 'listposts.php', queryParams);
      var response =
          await http.get(uri, headers: {'Cookie': "PHPSESSID=$sessionState"});


      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        return {'error': 'Server Error'};
      }
    } catch (e) {
      return {'error': 'Connection Error'};
    }
  }
}


