import 'package:bikerider/Screens/trip_summary_create.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Http/mapHttp.dart';
import '../Models/create_trip_modal.dart';
import '../Models/milestone.dart';
import '../Providers/invite_provider.dart';
import '../Utility/enums.dart';
import '../custom/widgets/CustomCard.dart';
import '../custom/widgets/button.dart';
import '../custom/widgets/text_form_fields.dart';
import 'invite_people.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({Key? key}) : super(key: key);

  @override
  State<CreateTrip> createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CreateTripModal.clearAll();
    //  Provider.of<InviteProvider>(context, listen: true).selectedContact.clear();
  }

  // Future<DateTime?> getDate() {
  //   return showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2018),
  //     lastDate: DateTime(2030),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light(),
  //         child: child!,
  //       );
  //     },
  //   );
  // }
  String? validate(String value) {
    if (value.isEmpty) {
      return 'Enter a value';
    } else {
      return null;
    }
  }

  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController nameOfTrip = TextEditingController();

  // TextEditingController temp1 = TextEditingController();
  // TextEditingController temp2 = TextEditingController();
  List<MilestoneModal> milestone = [];
  Map recommendations = {
    'Riding Gear': false,
    'Winter wear': false,
    'Summer wear': false,
    'Drinking water': false,
    'Bring Food': false
  };
  TextEditingController mainTo = TextEditingController();
  TextEditingController mainFrom = TextEditingController();
  TextEditingController tripeName = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create a Trip',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 22.5,
          ),
        ),
        backgroundColor: const Color(0xFFED863A),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   child: ElevatedButton(
                    //     onPressed: () async {
                    //       // DateTime? pickedDate = await showDatePicker(
                    //       //   context: context,
                    //       //   initialDate: DateTime.now(),
                    //       //   firstDate: DateTime(1950),
                    //       //   //DateTime.now() - not to allow to choose before today.
                    //       //   lastDate: DateTime(2100),
                    //       //   builder: (context, child) {
                    //       //     return Theme(
                    //       //       data: Theme.of(context).copyWith(
                    //       //         colorScheme: const ColorScheme.light(
                    //       //           primary: Colors.orangeAccent,
                    //       //           onPrimary: Colors.white,
                    //       //           onSurface: Colors.black,
                    //       //         ),
                    //       //         textButtonTheme: TextButtonThemeData(
                    //       //           style: TextButton.styleFrom(
                    //       //             primary: Colors.red, // button text color
                    //       //           ),
                    //       //         ),
                    //       //       ),
                    //       //       child: child!,
                    //       //     );
                    //       //   },
                    //       // );
                    //       TimeOfDay? pickedDate = await showTimePicker(
                    //         context: context,
                    //         initialTime: TimeOfDay(hour: 10, minute: 47),
                    //         builder: (context, child) {
                    //           return Theme(
                    //             data: ThemeData.light().copyWith(
                    //               colorScheme: const ColorScheme.light(
                    //                 // change the border color
                    //                 primary: Colors.orange,
                    //                 // change the text color
                    //                 onSurface: Colors.orange,
                    //               ),
                    //               // button colors
                    //               buttonTheme: const ButtonThemeData(
                    //                 colorScheme: ColorScheme.light(
                    //                   primary: Colors.black,
                    //                 ),
                    //               ),
                    //             ),
                    //             child: child!,
                    //           );
                    //         },
                    //       );
                    //
                    //       if (pickedDate != null) {
                    //         print(pickedDate);
                    //         //pickedDate output format => 2021-03-10 00:00:00.000
                    //         // String formattedDate =
                    //         //     DateFormat('yyyy-MM-dd').format(pickedDate);
                    //         // print(
                    //         //     formattedDate); //formatted date output using intl package =>  2021-03-16
                    //         // setState(() {
                    //         //   dateInput.text =
                    //         //       formattedDate; //set output date to TextField value.
                    //         // });
                    //       } else {}
                    //     },
                    //     child: Text('Pick Date'),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomSmallTextFormField(
                      textFieldType: TextFieldType.location,
                      // prefix: false,
                      enable: false,
                      label: 'Where do you want to go?',
                      controller: mainTo,
                      width: MediaQuery.of(context).size.width * 0.8,
                      locationType: MilestoneType.to,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomSmallTextFormField(
                      locationType: MilestoneType.from,
                      textFieldType: TextFieldType.location,
                      // prefix: false,
                      label: 'From',
                      controller: mainFrom,
                      width: MediaQuery.of(context).size.width * 0.8,
                      enable: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomSmallTextFormField(
                      textFieldType: TextFieldType.custom,
                      // prefix: false,
                      label: 'Name of the trip',
                      controller: nameOfTrip,
                      width: MediaQuery.of(context).size.width * 0.8,
                      enable: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSmallTextFormField(
                          textFieldType: TextFieldType.date,
                          label: 'Start Date',
                          controller: startDate,
                          enable: false,
                          width: MediaQuery.of(context).size.width > 200
                              ? MediaQuery.of(context).size.width * 0.36
                              : null,
                        ),
                        // SizedBox(width: 10,),
                        CustomSmallTextFormField(
                          textFieldType: TextFieldType.date,
                          label: 'End Date',
                          controller: endDate,
                          enable: false,
                          width: MediaQuery.of(context).size.width > 200
                              ? MediaQuery.of(context).size.width * 0.35
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSmallTextFormField(
                          textFieldType: TextFieldType.clock,
                          label: 'Start Time',
                          controller: startTime,
                          enable: false,
                          width: MediaQuery.of(context).size.width > 200
                              ? MediaQuery.of(context).size.width * 0.4
                              : null,
                          // validate: validate(startTime),
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Recommendation',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF4F504F),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...recommendations.entries.toList().map(
                                (e) => TextCircularButton(
                                  label: e.key,
                                  selected: e.value,
                                  callBack: (bool selected) {
                                    print(
                                        '${e.key}  ${recommendations[e.key]}');
                                    recommendations[e.key] = selected;
                                    print(
                                        'After:${e.key}  ${recommendations[e.key]}');
                                  },
                                ),
                              ),
                          // TextCircularButton(
                          //   label: 'Riding Gear',
                          //   selected: recommendations['Riding Gear'],
                          //   callBack: (bool selected) {
                          //     print('Before:  ${recommendations['Riding Gear']}');
                          //     recommendations['Riding Gear'] = selected;
                          //     print('After:  ${recommendations['Riding Gear']}');
                          //   },
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // TextCircularButton(
                          //   label: 'Winter wear',
                          //   selected: recommendations['Winter wear'],
                          //   callBack: (bool selected) {
                          //     print('Before:  ${recommendations['Winter wear']}');
                          //     recommendations['Winter wear'] = selected;
                          //     print('After:  ${recommendations['Winter wear']}');
                          //   },
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // TextCircularButton(
                          //   label: 'Summer wear',
                          //   selected: recommendations['Summer wear'],
                          //   callBack: (bool selected) {
                          //     print('Before:  ${recommendations['Summer wear']}');
                          //     recommendations['Summer wear'] = selected;
                          //     print('After:  ${recommendations['Summer wear']}');
                          //   },
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // TextCircularButton(
                          //   label: 'Drinking water',
                          //   selected: recommendations['Drinking water'],
                          //   callBack: (bool selected) {
                          //     print('Before:  ${recommendations['Drinking water']}');
                          //     recommendations['Drinking water'] = selected;
                          //     print('After:  ${recommendations['Drinking water']}');
                          //   },
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // TextCircularButton(
                          //   label: 'Bring Food',
                          //   selected: recommendations['Bring Food'],
                          //   callBack: (bool selected) {
                          //     print('Before:  ${recommendations['Bring Food']}');
                          //     recommendations['Bring Foodr'] = selected;
                          //     recommendations['Bring Food'] = selected;
                          //     print('After:  ${recommendations['Bring Food']}');
                          //   },
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                // height: 30,
                // thickness: 2,
                color: milestone.isNotEmpty ? Colors.transparent : null,
                height: 30,
                thickness: milestone.isEmpty ? 2 : 0,
              ),
              // const Divider(
              //   height: 30,
              //   thickness: 2,
              // ),
              GestureDetector(
                onTap: () {
                  debugPrint('Add a invite button pressed');
                  // print('encrypt');
                  // encryptTest();
                  Navigator.pushNamed(context, '/InvitePage');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const InvitePage(),
                  //   ),
                  // );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        children: [
                          CircularButton(
                            type: CircularButtonType.invite,
                            callBack: () {
                              debugPrint('Add a invite button pressed');
                              Navigator.pushNamed(context, '/InvitePage');
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const InvitePage(),
                              //   ),
                              // );
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Provider.of<InviteProvider>(context, listen: true)
                                  .selectedContact
                                  .isEmpty
                              ? Text(
                                  'Invite other riders',
                                  style: GoogleFonts.robotoFlex(
                                    color: const Color(0xFF4F504F),
                                    fontSize: 20,
                                  ),
                                )
                              : Container(
                                  // color: Colors.black,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ...Provider.of<InviteProvider>(context,
                                                listen: true)
                                            .selectedContact
                                            .map(
                                              (e) => Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  child: Image.asset(
                                                    'assets/images/create_trip/rider.png',
                                                  ),
                                                  // Text(
                                                  //   e.initials,
                                                  //   style:
                                                  //       GoogleFonts.robotoFlex(
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Divider(
                      // height: 30,
                      // thickness: 2,
                      color: milestone.isNotEmpty ? Colors.transparent : null,
                      height: 30,
                      thickness: milestone.isEmpty ? 2 : 0,
                    ),
                  ],
                ),
              ),
              // Container(
              //   // color: Colors.red,
              //   child: MileStoneLarge(
              //     toLocation: temp1,
              //     fromLocation: temp2,
              //   ),
              // ),
              ...CreateTripModal.milestone.map(
                (e) => MileStoneLarge(
                    milestone: e,
                    removeCard: (int id) {
                      setState(() {
                        CreateTripModal.milestone.removeWhere(
                            (element) => element.milestoneId == id);
                        for (int i = 0;
                            i < CreateTripModal.milestone.length;
                            i++) {
                          CreateTripModal.milestone[i].milestoneId = i + 1;
                        }
                        // milestone.forEach((element) {
                        //   element.milestoneId = milestone.indexWhere(
                        //           (indexElement) =>
                        //               indexElement.milestoneId ==
                        //               element.milestoneId) +
                        //       1;
                        // });
                      });
                    }),
              ),
              Divider(
                color: milestone.isEmpty ? Colors.transparent : null,
                height: milestone.isNotEmpty ? 30 : 0,
                thickness: milestone.isNotEmpty ? 2 : 0,
              ),
              GestureDetector(
                onTap: () {
                  debugPrint('Add a milestone button pressed');
                  milestone.forEach((element) {
                    print(element.fromController.text);
                    // print(element.from);
                    print('Details');
                    getLocationDetails(element.fromController.text)
                        .then((value) => print(value));
                    getLocationDetails(element.toController.text)
                        .then((value) => print(value));
                  });
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        children: [
                          CircularButton(
                            type: CircularButtonType.milestone,
                            callBack: () {
                              debugPrint('Add a milestone button pressed');

                              setState(() {
                                CreateTripModal.milestone.add(
                                  MilestoneModal(
                                    milestoneId:
                                        CreateTripModal.milestone.length + 1,
                                  ),
                                );
                                // milestone.add(
                                //   MilestoneModal(
                                //     milestoneId: milestone.length + 1,
                                //   ),
                                // );
                              });
                              print(milestone.length);
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                CreateTripModal.milestone.add(
                                  MilestoneModal(
                                    milestoneId:
                                        CreateTripModal.milestone.length + 1,
                                  ),
                                );
                                // milestone.add(
                                //   MilestoneModal(
                                //     milestoneId: milestone.length + 1,
                                //   ),
                                // );
                              });
                            },
                            child: Text(
                              'Add a milestone',
                              style: GoogleFonts.robotoFlex(
                                color: const Color(0xFF4F504F),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 30,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  // CreateTripModal.printContacts();
                  // print(formKey.currentState!.validate());
                  // for (var element in milestone) {
                  //   print(element);
                  // }
                  // List temp;
                  // getDirections().then((value) {
                  //   print(value);
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => TripSummary(points: value),
                  //     ),
                  //   );
                  // });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const TripSummary(),
                  //   ),
                  // );
                  if (nameOfTrip.text.isNotEmpty) {
                    CreateTripModal.tripName = nameOfTrip.text;
                  }
                  // CreateTripModal.printFromDetails();
                  // CreateTripModal.printToDetails();
                  // CreateTripModal.printStartDate();
                  // CreateTripModal.printEndDate();
                  // CreateTripModal.printTripName();
                  // CreateTripModal.printStartTime();
                  // CreateTripModal.printContacts();
                  // CreateTripModal.printMilestones();
                  // CreateTripModal.getDistance();
                  // print(CreateTripModal().toJson());
                  if (formKey.currentState!.validate()) {
                    // showToast(msg: 'Creating Trip :)');
                    // getDirections(CreateTripModal.fromDetails!,
                    //         CreateTripModal.toDetails!)
                    //     .then(
                    //   (value) {
                    //     CreateTripModal.distance = value;
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => TripSummary(),
                    //       ),
                    //     );
                    //   },
                    // );
                    // CreateTripModal.printAll();
                    // double zoom =
                    //     (CreateTripModal.distance!.points.length).toDouble();
                    // print('length: $zoom');
                    CreateTripModal.printMilestones();
                    CreateTripModal.printContacts();
                    Navigator.pushNamed(context, '/TripSummaryCreate');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => TripSummaryCreate(),
                    //   ),
                    // );
                  }
                },
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    // color: const Color(0xFFFFCAA1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'DONE',
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
