import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Http/mapHttp.dart';
import '../Models/autocomplete.dart';
import '../Models/create_trip_modal.dart';
import '../Models/milestone.dart';
import '../Utility/enums.dart';

class SearchDestination extends StatefulWidget {
  SearchDestination({
    Key? key,
    required this.controller,
    required this.type,
    required this.locationDetails,
    // required this.callBack,
  }) : super(key: key);
  final TextEditingController controller;
  final MilestoneType type;
  MilestoneModal? locationDetails;
  // final Function callBack;
  @override
  State<SearchDestination> createState() => _SearchDestinationState();
}

class _SearchDestinationState extends State<SearchDestination> {
  List<LocationDetails> locationsList = [];
  // List<String> suggestion = [];
  // HttpService service = HttpService();
  // TextEditingController localController = TextEditingController();

  getSuggestionData(String location) async {
    await getSuggestions(location).then((value) {
      locationsList.clear();
      for (var item in jsonDecode(value.body)['results']) {
        Map temp = item['geo'];
        locationsList.add(
          LocationDetails(
            place: temp['name'],
            latitude: temp['center']['latitude'],
            longitude: temp['center']['longitude'],
          ),
        );
        print('Test');
        locationsList.forEach((element) => print(element));
      }
      setState(() {
        // locationsList;
      });
      // suggestion.clear();
      // for (var item in jsonDecode(value.body)["results"]) {
      //   String fullName = item['text']['primary'];
      //   int index = fullName.indexOf(',');
      //   suggestion.add(fullName);
      // }
      // print(suggestion);
      // print(suggestion.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.text.length > 3
        ? getSuggestionData(widget.controller.text)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                enabled: true,
                controller: widget.controller,
                onChanged: (value) {
                  getSuggestionData(value);
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: IconButton(
                    splashRadius: 15,
                    onPressed: () {
                      widget.controller.clear();
                      // setState(() {
                      //   // suggestion = [];
                      // });
                      // widget.controller.text = 'value';
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black45,
                    ),
                  ),
                  label: Text(
                      widget.type == MilestoneType.from ? 'From' : 'Where to?'),
                  // labelStyle: GoogleFonts.roboto(
                  //   color: const Color(0xFF4F504F).withOpacity(0.8),
                  //   fontSize: 15,
                  //   fontWeight: FontWeight.w500,
                  // ),
                  floatingLabelStyle: GoogleFonts.robotoFlex(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  border: const UnderlineInputBorder(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  // errorBorder: const UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.grey),
                  // ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  // errorStyle: GoogleFonts.roboto(
                  //   color: Colors.orangeAccent,
                  //   fontSize: 12,
                  //   fontWeight: FontWeight.w400,
                  // ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ...locationsList.map(
                (e) => Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/search/mapIcon.png',
                          scale: 3,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.type == MilestoneType.from
                                ? widget.locationDetails?.from = e
                                : widget.locationDetails?.to = e;
                            print(widget.locationDetails?.milestoneId ??
                                'Not present');
                            widget.controller.text = e.place;
                            if (widget.locationDetails?.milestoneId == null) {
                              widget.type == MilestoneType.from
                                  ? CreateTripModal.fromDetails = e
                                  : CreateTripModal.toDetails = e;
                            }
                            // widget.callBack(e);
                            // localController.text = e.name;
                            // setState(() {});
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text(
                              e.place,
                              style: GoogleFonts.robotoFlex(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1,
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 35,
                      thickness: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       margin: EdgeInsets.all(20),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 10,
//             ),
//             TextField(
//               enabled: true,
//               controller: destinationController,
//               onChanged: (value) {},
//               decoration: InputDecoration(
//                 // suffixIcon: Image.asset("assets/cancel.png"),
//
//                 suffixIcon: IconButton(
//                   onPressed: () {
//                     destinationController.clear();
//                     setState(() {
//                       suggestion = [];
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.close,
//                     color: Colors.black45,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                 labelText: "Where to?",
//                 labelStyle: GoogleFonts.roboto(
//                   color: const Color.fromRGBO(166, 166, 166, 0.87),
//                   fontSize: 14,
//                 ),
//                 focusedBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Color.fromRGBO(194, 188, 188, 0.5),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height - 420,
//               child: FutureBuilder<dynamic>(
//                 future: getSuggestionData(destinationController.text),
//                 builder:
//                     (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (snapshot.connectionState ==
//                       ConnectionState.done) {
//                     return ListView.builder(
//                         padding: const EdgeInsets.all(0),
//                         itemCount: suggestion.length,
//                         itemBuilder: (BuildContext ctxt, int index) {
//                           return GestureDetector(
//                             onTap: () {
//                               destinationController.text = suggestion[index];
//                               widget.controller.text = suggestion[index];
//                             },
//                             child: Column(
//                               children: [
//                                 ListTile(
//                                   leading: Image.asset(
//                                     'assets/images/search/mapIcon.png',
//                                     width: 20,
//                                   ),
//                                   title: Text(
//                                     suggestion[index],
//                                     style: GoogleFonts.roboto(),
//                                   ),
//                                   subtitle: Text(
//                                     suggestion[index],
//                                     style: GoogleFonts.roboto(),
//                                   ),
//                                 ),
//                                 // const SizedBox(
//                                 //   height: 5,
//                                 // ),
//                                 const Divider(
//                                   color: Color(0xff979797),
//                                   thickness: 0.5,
//                                 ),
//                               ],
//                             ),
//                           );
//                         });
//                   } else {
//                     return const Text("ERROR");
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
