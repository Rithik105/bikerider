import 'dart:convert';

import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Http/BookService.dart';
import '../../Models/workstation_model.dart';
import '../../custom/widgets/ServiceCard.dart';

class WorkstationSuggestion extends StatefulWidget {
  const WorkstationSuggestion({Key? key}) : super(key: key);

  @override
  State<WorkstationSuggestion> createState() => _WorkstationSuggestionState();
}

class _WorkstationSuggestionState extends State<WorkstationSuggestion> {
  List<WorkstationModel> workstations = [];
  TextEditingController workstationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Color(0xcfED7E2B),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              enabled: true,
              controller: workstationController,
              onChanged: (value) {
                print(value);
                if (value.isEmpty) {
                  workstations.clear();
                  setState(() {});
                } else {
                  BookServiceHttp.getWorkstations(workstationController.text)
                      .then((value) {
                    workstations.clear();

                    for (var e in jsonDecode(value.body)) {
                      workstations.add(WorkstationModel.fromJson(e));
                    }

                    setState(() {});
                  });
                }
              },
              decoration: InputDecoration(
                // suffixIcon: Image.asset("assets/cancel.png"),

                suffixIcon: IconButton(
                  onPressed: () {
                    workstationController.clear();
                    workstations = [];
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black45,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: "Search",
                labelStyle: GoogleFonts.roboto(
                    color: Color.fromRGBO(166, 166, 166, 0.87), fontSize: 18),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffB4B3B3),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ...workstations.map((e) {
              return ServiceCard(
                workstation: e,
              );
            })
          ],
        ),
      ).paddingAll(20, 20, 0, 20),
    );
  }
}
