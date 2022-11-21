import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../Providers/invite_provider.dart';

class InvitePageTest extends StatefulWidget {
  const InvitePageTest({Key? key}) : super(key: key);

  @override
  State<InvitePageTest> createState() => _InvitePageTestState();
}

class _InvitePageTestState extends State<InvitePageTest> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    getAllContacts();
    searchController.addListener(() {
      filterContacts();
    });
    print('works');
  }

  convertToPhoneNumber(Contact contact) {
    // print(contact.phones?.elementAt(0).value.toString().split(' ')[1]);
    // For Emulator -> the format of contact storing will be differnt, so use the below line while running emulator.
    // return '${contact.phones?.elementAt(0).value.toString().substring(1, 4)}${contact.phones?.elementAt(0).value.toString().substring(6, 9)}${contact.phones?.elementAt(0).value.toString().split('-')[1]}';
    // print(
    //     '${contact.phones?.elementAt(0).value.toString().substring(1, 4)}${contact.phones?.elementAt(0).value.toString().substring(6, 9)}${contact.phones?.elementAt(0).value.toString().split(' ')[1]}');
    if (contact.phones?.elementAt(0).value.toString().length == 12) {
      print(contact.phones?.elementAt(0).value);
      List<String>? temp =
          contact.phones?.elementAt(0).value.toString().split(' ');
      return '${temp![1]}${temp[2]}';
    }
    if (contact.phones?.elementAt(0).value.toString()[0] == '(') {
      print(
          '${contact.phones?.elementAt(0).value.toString().substring(1, 4)}${contact.phones?.elementAt(0).value.toString().substring(6, 9)}${contact.phones?.elementAt(0).value.toString().split('-')[1]}');
      return '${contact.phones?.elementAt(0).value.toString().substring(1, 4)}${contact.phones?.elementAt(0).value.toString().substring(6, 9)}${contact.phones?.elementAt(0).value.toString().split('-')[1]}';
    }
    print(
        '${contact.phones?.elementAt(0).value.toString().substring(1, 4)}${contact.phones?.elementAt(0).value.toString().substring(6, 9)}${contact.phones?.elementAt(0).value.toString().split(' ')[1]}');
    return '${contact.phones?.elementAt(0).value.toString().substring(1, 4)}${contact.phones?.elementAt(0).value.toString().substring(6, 9)}${contact.phones?.elementAt(0).value.toString().split(' ')[1]}';
  }

  getAllContacts() async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> _contacts = (await ContactsService.getContacts()).toList();
      setState(() {
        contacts = _contacts;
      });
    } else {
      await Permission.contacts.request();
    }
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String? contactName = contact.displayName?.toLowerCase();
        return contactName!.contains(searchTerm);
      });
      setState(() {
        contactsFiltered = _contacts;
      });
    }
    print(contacts);
  }

  // bool isSearching = searchController.text.isNotEmpty;
  @override
  Widget build(BuildContext context) {
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
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          children: [
            Material(
              elevation: 3.0,
              shadowColor: const Color.fromRGBO(194, 188, 188, 0.5),
              child: TextField(
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
            Column(
              children: [
                ...contacts.map(
                  (e) => GestureDetector(
                    onTap: () {
                      Provider.of<InviteProvider>(context, listen: false)
                          .toggleContact(ContactDetails(
                        name: e.displayName.toString(),
                        phoneNumber: convertToPhoneNumber(e),
                      ));
                    },
                    child: Container(
                      height: 30,
                      child: ListTile(
                        title: Text(
                          e.displayName.toString(),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: const Color.fromRGBO(0, 0, 0, 0.87)),
                        ),
                        leading: ((e.avatar != null) && (e.avatar!.isNotEmpty))
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(e.avatar!),
                              )
                            : CircleAvatar(
                                backgroundColor:
                                    const Color.fromRGBO(0, 0, 0, 0.38),
                                child: Text(
                                  e.initials(),
                                  style: GoogleFonts.robotoFlex(
                                      color: Colors.white),
                                ),
                              ),
                        trailing: Consumer<InviteProvider>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return value.isExist(
                              ContactDetails(
                                name: e.displayName.toString(),
                                phoneNumber: convertToPhoneNumber(e),
                              ),
                            )
                                ? Image.asset(
                                    "assets/images/contacts/green_check.png",
                                    width: 30,
                                  )
                                : Image.asset(
                                    "assets/images/contacts/white_check.png",
                                    width: 30,
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
