class InvoiceModel {
  String? invoiceId;
  String? serviceId;
  String? invoiceNumber;
  String? invoiceDate;
  bool? paid;
  int? total;
  List<ItemDetails> itemList = [];
  InvoiceModel.fromJson(Map json) {
    invoiceId = json['invoiceId'];
    invoiceNumber = json['invoiceNumber'];
    invoiceDate = json['invoiceDate'];
    paid = json['paid'];
    total = json['total'];

    json['items'].forEach((e) => itemList.add(ItemDetails.fromJson(e)));
  }
}

class ItemDetails {
  String? itemName;
  int? itemQuantity;
  int? itemPrice;
  ItemDetails.fromJson(var json) {
    itemName = json['itemName'];
    itemQuantity = json['itemQuantity'];
    itemPrice = json['itemPrice'];
  }
}
