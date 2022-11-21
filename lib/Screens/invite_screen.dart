import 'package:bikerider/Models/create_trip_modal.dart';
import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:bikerider/Providers/invite_provider.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  List<bool> selected = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getAllContacts("").then((value) {
      for (int i = 0; i < value.length; i++) {
        if (value[i].phones!.length >= 1) {
          contacts.add(value[i]);
        }
      }
      // contacts = value.map((e) {
      //   if (e.phones.length == 1) {
      //     return e;
      //   }
      // }).toList();
      setState(() {});
    });
  }

  convertToPhoneNumber(Contact contact) {
    String number;
    if (contact.phones == null) {
      return "0000000000";
    } else {
      number = contact.phones!.elementAt(0).value!.trim().replaceAll(' ', '');
      number = number.replaceAll('-', '');
      number = number.replaceAll('+', '');
      number = number.replaceAll('(', '');
      number = number.replaceAll(')', '');
      if (number.length == 12) {
        number = number.substring(2);
      }
      print(number);
      return number;
    }
  }

  Future<List<Contact>> getAllContacts(String search) async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> contactes =
          (await ContactsService.getContacts(query: search)).toList();
      List<bool> temp = List.filled(contactes.length, false, growable: true);
      selected = temp;
      return contactes;
    } else {
      await Permission.contacts.request();
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xFFED863A),
          centerTitle: true,
          title: Text(
            'Invite People',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 22.5,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(children: [
            Material(
              elevation: 3.0,
              shadowColor: const Color.fromRGBO(194, 188, 188, 0.5),
              child: TextField(
                onSubmitted: (value) {
                  getAllContacts(value).then((value2) {
                    contacts.clear();
                    for (int i = 0; i < value2.length; i++) {
                      if (value2[i].phones!.length >= 1) {
                        print(value2[i].displayName);
                        contacts.add(value2[i]);
                      }
                    }
                    setState(() {});
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Search Name",
                  labelStyle: GoogleFonts.roboto(
                    color: const Color.fromRGBO(166, 166, 166, 0.87),
                    fontSize: 14,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(194, 188, 188, 0.5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 4.0)),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    selected[index] =
                        Provider.of<InviteProvider>(context, listen: false)
                            .isExist(ContactDetails(
                                name: contacts[index].displayName.toString(),
                                phoneNumber:
                                    convertToPhoneNumber(contacts[index])));

                    return GestureDetector(
                      onTap: () {
                        selected[index] = !selected[index];
                        setState(() {});
                        Provider.of<InviteProvider>(context, listen: false)
                            .toggleContact(ContactDetails(
                                name: contacts[index].displayName.toString(),
                                phoneNumber:
                                    convertToPhoneNumber(contacts[index])));
                      },
                      child: ListTile(
                        title: Text(
                          contacts[index].displayName.toString(),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: const Color.fromRGBO(0, 0, 0, 0.87)),
                        ),
                        leading: ((contacts[index].avatar != null) &&
                                (contacts[index].avatar!.isNotEmpty))
                            ? CircleAvatar(
                                backgroundImage:
                                    MemoryImage(contacts[index].avatar!),
                              )
                            : CircleAvatar(
                                backgroundColor:
                                    const Color.fromRGBO(0, 0, 0, 0.38),
                                child: Text(
                                  contacts[index].initials(),
                                  style: GoogleFonts.robotoFlex(
                                      color: Colors.white),
                                ),
                              ),
                        trailing: GestureDetector(
                            onTap: () {
                              selected[index] = !selected[index];
                              setState(() {});
                              Provider.of<InviteProvider>(context,
                                      listen: false)
                                  .toggleContact(ContactDetails(
                                      name: contacts[index]
                                          .displayName
                                          .toString(),
                                      phoneNumber: convertToPhoneNumber(
                                          contacts[index])));
                            },
                            child: selected[index]
                                ? Image.asset(
                                    "assets/images/contacts/green_check.png",
                                    width: 30,
                                  )
                                : Image.asset(
                                    "assets/images/contacts/white_check.png",
                                    width: 30,
                                  )),
                      ),
                    );
                  }),
            ),
          ]),
        ));
  }
}
