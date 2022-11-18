class ProductInvoiceModel {
  String? invoiceId;
  String? serviceId;
  String? invoiceNumber;
 DateTime? invoiceDate;
  bool? paid;
  int? total;
  List<ItemDetails> itemList = [];
  ProductInvoiceModel.fromJson(Map json) {
    invoiceId = json['invoiceId'];
    invoiceNumber = json['invoiceNumber'];
    invoiceDate = DateTime.parse(json['invoiceDate']);
    paid = json['paid'];
    total = json['total'];
    serviceId=json["serviceId"];
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
