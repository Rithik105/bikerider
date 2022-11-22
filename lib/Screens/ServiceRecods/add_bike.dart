import 'package:bikerider/Http/AddBikeHttp.dart';
import 'package:bikerider/Models/bike_list_model.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Models/add_bike_model.dart';
import '../../custom/constants.dart';
import '../../custom/widgets/button.dart';
class AddBike extends StatefulWidget {
  AddBike({
    Key? key,
// required this.bikeList
  }) : super(key: key);
// final List<BikeListModel> bikeList;
  @override
  State<AddBike> createState() => _AddBikeState();
}
class _AddBikeState extends State<AddBike> {
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController frameController = TextEditingController();
  TextEditingController batteryController = TextEditingController();
  TextEditingController regController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController dealerCodeController = TextEditingController();
  String vehicleType = "Royal Enfield Himalayan";
  List<BikeListModel> bikeList = [];
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  int i = 0;
  @override
  void initState() {
// TODO: implement initState
    super.initState();
    print('InitState');
    AddBikeHttp.addBikeList().then(
          (value) {
        print(value);
        bikeList.clear();
        for (var e in value) {
          bikeList.add(BikeListModel.fromJson(e));
        }
        setState(() {});
      },
    );
  }
  @override
  void dispose() {
    vehicleNoController.dispose();
    engineController.dispose();
    frameController.dispose();
    batteryController.dispose();
    regController.dispose();
    modelController.dispose();
    colorController.dispose();
    dealerCodeController.dispose();
    super.dispose();
    print('Dispose');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffed863a),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Text(
          'Add Bike Details',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: Center(
        child: bikeList.isEmpty
            ? const CircularProgressIndicator(
          color: Colors.orange,
        )
            : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 150,
                child: PageView(
                  onPageChanged: (value) {
                    bikeList.forEach((element) {
                      print(element.vehicleImage);
                    });
                    print(value);
                    setState(() {
                      i = value;
                    });
                  },
                  controller: _pageController,
                  children: [
                    ...bikeList.map(
                          (e) => Image.network(e.vehicleImage),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Vehicle Type",
                            style: kBikeGeneralTextStyle,
                          ),
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 200,
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            icon: Image.asset(
                                "assets/images/book_service/drop_down.png",
                                width: 10),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                            ),
                            items: [
                              ...bikeList
                                  .map(
                                    (e) => DropdownMenuItem(
                                  value: e.vehicleType,
                                  child: Text(
                                    e.vehicleType,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ],
                            value: bikeList[i].vehicleType,
                            onChanged: (value) {
                              print(bikeList);
                              print(value.runtimeType);
                              vehicleType = value!;
                              _pageController.jumpToPage(
                                  bikeList.indexWhere((element) =>
                                  value == element.vehicleType));
// setState(() {
// vehicleType = value!;
// print("service type ${vehicleType}");
// });
//vehicleType = value as String;
                            },
                            itemHeight: 60,
                          ),
// TextField(
// controller: vehicleTypeController,
// textInputAction: TextInputAction.next,
// decoration: const InputDecoration(
// focusedBorder: UnderlineInputBorder(
// borderSide: BorderSide(
// color: Color(0xffB4B3B3),
// ),
// ),
// ),
// // style: kDetailsTextStyle,
// ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Engine",
                            style: kBikeGeneralTextStyle,
                          ),
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: engineController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Engine';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: GoogleFonts.roboto(
                                color: Colors.orangeAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ),
//style: kDetailsTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Frame No",
                            style: kBikeGeneralTextStyle,
                          ),
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: frameController,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Frame Number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: GoogleFonts.roboto(
                                color: Colors.orangeAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ),
// style: kDetailsTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Battery make",
                            style: kBikeGeneralTextStyle,
                          ),
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: batteryController,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the battery make';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: GoogleFonts.roboto(
                                color: Colors.orangeAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ),
// style: kDetailsTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Reg No.",
                            style: kBikeGeneralTextStyle,
                          ),
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: regController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Registration number';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration:InputDecoration(
                              errorStyle: GoogleFonts.roboto(
                                color: Colors.orangeAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ),
// style: kDetailsTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Model",
                            style: kBikeGeneralTextStyle,
                          ),
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            controller: modelController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the model';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: GoogleFonts.roboto(
                                color: Colors.orangeAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ),
// style: kDetailsTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Dealer code",
                            style: kBikeGeneralTextStyle,
                          ),
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: dealerCodeController,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the dealer code';
                              }
                              return null;
                            },
//style: kDetailsTextStyle,
                            decoration: InputDecoration(
                              errorStyle: GoogleFonts.roboto(
                                color: Colors.orangeAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Vehicle Number",
                            style: kBikeGeneralTextStyle,
                          ),
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: vehicleNoController,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the vehicle number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: GoogleFonts.roboto(
                                color: Colors.orangeAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ),
// style: kDetailsTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: 120,
                            child: Text(
                              "Color",
                              style: kBikeGeneralTextStyle,
                            )),
                        const Text(':'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: colorController,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Color';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: GoogleFonts.roboto(
                                color: Colors.orangeAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ),
//style: kDetailsTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: LargeSubmitButton(
                  text: "Submit",
                  ontap: () {
//AddBikeModel(vehicleNumber: vehicleNoController.text, vehicleType: vehicleTypeController.text, engineNumber: engineController.text, batteryMake: batteryController.text, frameNumber: frameController.text, registerNumber: regController.text, model: modelController.text, color: colorController.text, dealerCode: dealerCodeController.text);
                    if (_formKey.currentState!.validate()) {
                      AddBikeHttp.addBikeDetails(
                        AddBikeModel(
                          vehicleNumber: vehicleNoController.text,
                          vehicleType: vehicleType,
                          engineNumber: engineController.text,
                          batteryMake: batteryController.text,
                          frameNumber: frameController.text,
                          registerNumber: regController.text,
                          model: modelController.text,
                          color: colorController.text,
                          dealerCode: dealerCodeController.text,
                        ).toJson(),
                      );
                      showToast(msg: "Bike details added successfully");
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ).paddingAll(30, 30, 30, 30),
        ),
      ),
    );
  }
}