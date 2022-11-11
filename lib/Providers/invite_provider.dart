import 'package:flutter/material.dart';

import '../Models/create_trip_modal.dart';

class InviteProvider extends ChangeNotifier {
  // List<String> selectedContact = [];
  List<ContactDetails> selectedContact = [];
  toggleContact(
      // String contactName, String phoneNumber, String initials
      ContactDetails contact) {
    // final isExists = selectedContact.contains(contact);
    print(contact);
    bool check = isExist(contact);
    if (check) {
      // selectedContact.remove(contact);
      selectedContact
          .removeWhere((element) => element.phoneNumber == contact.phoneNumber);
      CreateTripModal.contacts = selectedContact;
      notifyListeners();
    } else {
      selectedContact.add(contact);
      CreateTripModal.contacts = selectedContact;
      notifyListeners();
    }
    print('-');
    selectedContact.forEach((element) {
      print(element);
    });
    print('-');
  }

  bool isExist(ContactDetails contactDetails) {
    bool contains = false;
    for (int i = 0; i < selectedContact.length; i++) {
      if (selectedContact[i].phoneNumber == contactDetails.phoneNumber) {
        contains = true;
      }
    }
    return contains;
  }
  // bool isExists(String contact, String phone) {
  //   return selectedContact.contains(contact);
  // }
}

class ContactDetails {
  String? name;
  String? phoneNumber;
  //String? initials;
  ContactDetails({required this.name, required this.phoneNumber});
  Map toJson() {
    return {'name': name, 'phoneNumber': phoneNumber};
  }

  ContactDetails.fromJson(json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }
  // @override
  // String toString() {
  //   return 'name: $name, phoneNumber: $phoneNumber, initials: $initials';
  // }
}
