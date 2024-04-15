class Item {
  int itemID;
  String itemName;
  String itemDesc;
  String itemCondition;
  DateTime itemAdded;
  String itemPrice;
  String itemQuantity;
  bool itemWanted;
  String imagePath;
  int userID;

  Item({
    required this.itemID,
    required this.itemName,
    required this.itemDesc,
    required this.itemCondition,
    required this.itemAdded,
    required this.itemPrice,
    required this.itemQuantity,
    required this.itemWanted,
    required this.imagePath,
    required this.userID,
  });
}
