class Item {
  final int itemId;
  final String itemName;
  final String itemDesc;
  final String itemCondition;
  final double itemPrice;
  final bool itemWanted;
  final int userId;
  final DateTime itemAdded;


  Item({
    required this.itemId,
    required this.itemName,
    required this.itemDesc,
    required this.itemCondition,
    required this.itemPrice,
    required this.itemWanted,
    required this.userId,
    required this.itemAdded,
  });


}
