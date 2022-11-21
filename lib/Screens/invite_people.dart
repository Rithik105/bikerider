// // import 'package:contacts_service/contacts_service.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
//
// import '../Providers/invite_provider.dart';
//
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:provider/provider.dart';
// // import 'package:ride_app/screens/custom_padding.dart';
//
// // import '../Providers/invite_provider.dart';
//
// class InvitePage extends StatefulWidget {
//   const InvitePage({Key? key}) : super(key: key);
//
//   @override
//   State<InvitePage> createState() => _InvitePageState();
// }
//
// class _InvitePageState extends State<InvitePage> {
//   List<Contact> contacts = [];
//   List<Contact> contactsFiltered = [];
//   TextEditingController searchController = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     getAllContacts();
//     searchController.addListener(() {
//       filterContacts();
//     });
//   }
//
//   convertToPhoneNumber(contact) {
//     return '${contact.phones?.elementAt(0).value.toString().substring(1, 4)}${contact.phones?.elementAt(0).value.toString().substring(6, 9)}${contact.phones?.elementAt(0).value.toString().split('-')[1]}';
//   }
//
//   getAllContacts() async {
//     if (await Permission.contacts.request().isGranted) {
//       List<Contact> _contacts = (await ContactsService.getContacts()).toList();
//       setState(() {
//         contacts = _contacts;
//       });
//     } else {
//       await Permission.contacts.request();
//     }
//   }
//
//   filterContacts() {
//     List<Contact> _contacts = [];
//     _contacts.addAll(contacts);
//     if (searchController.text.isNotEmpty) {
//       _contacts.retainWhere((contact) {
//         String searchTerm = searchController.text.toLowerCase();
//         String? contactName = contact.displayName?.toLowerCase();
//         return contactName!.contains(searchTerm);
//       });
//       setState(() {
//         contactsFiltered = _contacts;
//       });
//     }
//     print(contacts);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isSearching = searchController.text.isNotEmpty;
//     return Scaffold(
//       appBar: AppBar(
//         // toolbarHeight: 80,
//         // leading: IconButton(
//         //   icon: const Icon(Icons.arrow_back),
//         //   color: Colors.white,
//         //   onPressed: () {
//         //     Navigator.pop(context);
//         //   },
//         // ),
//         leading: BackButton(
//           color: Colors.white,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: const Color(0xFFED863A),
//         centerTitle: true,
//         title: Text(
//           'Invite People',
//           style: GoogleFonts.roboto(
//             fontWeight: FontWeight.w600,
//             fontSize: 22.5,
//           ),
//         ),
//       ),
//       body: Padding(
//         // padding: const EdgeInsets.only(left: 20, right: 20, top: 20,),
//         padding: const EdgeInsets.all(
//           20,
//         ),
//         child: Column(
//           children: [
//             Material(
//               elevation: 3.0,
//               shadowColor: const Color.fromRGBO(194, 188, 188, 0.5),
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                   labelText: "Search Name",
//                   labelStyle: GoogleFonts.roboto(
//                     color: const Color.fromRGBO(166, 166, 166, 0.87),
//                     fontSize: 14,
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                   contentPadding:
//                       const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                   focusedBorder: const UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color.fromRGBO(194, 188, 188, 0.5),
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                       borderSide:
//                           const BorderSide(color: Colors.white, width: 4.0)),
//                   prefixIcon: const Icon(Icons.search),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: isSearching == true
//                     ? contactsFiltered.length
//                     : contacts.length,
//                 itemBuilder: (context, index) {
//                   Contact contact = isSearching == true
//                       ? contactsFiltered[index]
//                       : contacts[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Provider.of<InviteProvider>(context, listen: false).toggleContact(
//                           ContactDetails(
//                         name: contact.displayName.toString(),
//                         phoneNumber: convertToPhoneNumber(contact),
//                       )
//                           // print(contact.displayName);
//                           // // print(contact.avatar.runtimeType);
//                           // Provider.of<InviteProvider>(context, listen: false)
//                           //     .toggleContact(ContactDetails(
//                           //   name: contact.displayName.toString(),
//                           //   initials: contact.initials().toString(),
//                           //   phoneNumber:
//                           //       (contact.phones?.elementAt(0).value).toString(),
//                           // )
//                           // contact.displayName.toString(),
//                           // (contact.phones?.elementAt(0).value).toString(),
//                           // contact.initials().toString(),
//                           );
//                     },
//                     child: ListTile(
//                       title: Text(
//                         contact.displayName.toString(),
//                         textAlign: TextAlign.left,
//                         style: GoogleFonts.roboto(
//                             fontSize: 15,
//                             color: const Color.fromRGBO(0, 0, 0, 0.87)),
//                       ),
//                       //subtitle: Text((contact.phones?.elementAt(0).value).toString()),
//                       leading: ((contact.avatar != null) &&
//                               (contact.avatar!.isNotEmpty))
//                           ? CircleAvatar(
//                               //backgroundColor: Color.fromRGBO(0, 0, 0, 0.38),
//                               backgroundImage: MemoryImage(contact.avatar!),
//                             )
//                           : CircleAvatar(
//                               backgroundColor:
//                                   const Color.fromRGBO(0, 0, 0, 0.38),
//                               child: Text(
//                                 contact.initials(),
//                                 style:
//                                     GoogleFonts.robotoFlex(color: Colors.white),
//                               ),
//                             ),
//                       trailing: GestureDetector(
//                         onTap: () {
//                           // print(contact.displayName);
//                           // Provider.of<InviteProvider>(context, listen: false)
//                           //     .toggleContact(
//                           //   contact.displayName.toString(),
//                           //   (contact.phones?.elementAt(0).value).toString(),
//                           //   contact.initials().toString(),
//                           // );
//                           // print(
//                           //   convertToPhoneNumber(contact),
//                           // );
//                           // print('---------');
//                           // print(contact.phones?.elementAt(0).value);
//                           // print(
//                           //     '${contact.phones?.elementAt(0).value.toString().substring(1, 4)}${contact.phones?.elementAt(0).value.toString().substring(6, 9)}${contact.phones?.elementAt(0).value.toString().split('-')[1]}');
//                           // print('---------');
//                           Provider.of<InviteProvider>(context, listen: false)
//                               .toggleContact(ContactDetails(
//                             name: contact.displayName.toString(),
//                             phoneNumber: convertToPhoneNumber(contact),
//                           )
//                                   // Provider.of<InviteProvider>(context, listen: false)
//                                   //     .toggleContact(ContactDetails(
//                                   //   name: contact.displayName.toString(),
//                                   //   initials: contact.initials().toString(),
//                                   //   phoneNumber: (contact.phones?.elementAt(0).value)
//                                   //       .toString(),
//                                   // )
//                                   // contact.displayName.toString(),
//                                   // (contact.phones?.elementAt(0).value).toString(),
//                                   // contact.initials().toString(),
//                                   );
//                         },
//                         child: Consumer<InviteProvider>(
//                           builder:
//                               (BuildContext context, value, Widget? child) {
//                             return
//                                 // value.isExists(
//                                 //       contact.displayName.toString(),
//                                 //       (contact.phones?.elementAt(0).value)
//                                 //           .toString())
//                                 value.isExist(
//                               ContactDetails(
//                                 name: contact.displayName.toString(),
//                                 phoneNumber:
//                                     // (contact.phones?.elementAt(0).value)
//                                     //     .toString(),
//                                     convertToPhoneNumber(contact),
//                               ),
//                             )
//                                     ? Image.asset(
//                                         "assets/images/contacts/green_check.png",
//                                         width: 30,
//                                       )
//                                     : Image.asset(
//                                         "assets/images/contacts/white_check.png",
//                                         width: 30,
//                                       );
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
