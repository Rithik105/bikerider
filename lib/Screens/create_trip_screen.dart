import 'package:bikerider/Models/create_trip_modal.dart';
import 'package:bikerider/Models/milestone.dart';
import 'package:bikerider/Providers/invite_provider.dart';
import 'package:bikerider/Utility/enums.dart';
import 'package:bikerider/custom/widgets/CustomCard.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/button.dart';
import 'package:bikerider/custom/widgets/text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({Key? key}) : super(key: key);

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  @override
  void initState() {
    super.initState();
    CreateTripModal.clearAll();
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return 'Enter a value';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    CreateTripModal.contacts.clear();
  }

  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController nameOfTrip = TextEditingController();

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
                    const SizedBox(
                      height: 15,
                    ),
                    CustomSmallTextFormField(
                      textFieldType: TextFieldType.location,
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
                      label: 'From',
                      controller: mainFrom,
                      width: MediaQuery.of(context).size.width * 0.8,
                      enable: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomSmallTextFormField(
                      textFieldType: TextFieldType.tripName,
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
                        ),
                        const SizedBox(
                          width: 0,
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
                                  callBack: (bool selected) {},
                                ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: milestone.isNotEmpty ? Colors.transparent : null,
                height: 30,
                thickness: milestone.isEmpty ? 2 : 0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/InvitePage');
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
                              Navigator.pushNamed(context, '/InvitePage');
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
                              : SizedBox(
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
                      color: milestone.isNotEmpty ? Colors.transparent : null,
                      height: 30,
                      thickness: milestone.isEmpty ? 2 : 0,
                    ),
                  ],
                ),
              ),
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
                      });
                    }),
              ),
              Divider(
                color: milestone.isEmpty ? Colors.transparent : null,
                height: milestone.isNotEmpty ? 30 : 0,
                thickness: milestone.isNotEmpty ? 2 : 0,
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        children: [
                          CircularButton(
                            type: CircularButtonType.milestone,
                            callBack: () {
                              setState(() {
                                CreateTripModal.milestone.add(
                                  MilestoneModal(
                                    milestoneId:
                                        CreateTripModal.milestone.length + 1,
                                  ),
                                );
                              });
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
                  if (nameOfTrip.text.isNotEmpty) {
                    CreateTripModal.tripName = nameOfTrip.text;
                  }

                  if (formKey.currentState!.validate()) {
                    if (CreateTripModal.startDate!
                            .compareTo(CreateTripModal.endDate!) >
                        0) {
                      showToast(msg: 'End date cannot be before start date');
                    } else {
                      CreateTripModal.printMilestones();
                      CreateTripModal.printContacts();
                      Navigator.pushNamed(context, '/TripSummaryCreate');
                    }
                  }
                },
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange,
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
