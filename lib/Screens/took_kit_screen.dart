import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/tool_kit.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolKitScreen extends StatefulWidget {
  const ToolKitScreen({super.key});

  @override
  State<ToolKitScreen> createState() => _ToolKitScreenState();
}

class _ToolKitScreenState extends State<ToolKitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        toolbarHeight: 70,
        // leading: ,
        backgroundColor: const Color(0xFFED863A),
        centerTitle: true,
        title: Text(
          'Tool Kit',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 22.5,
          ),
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<BikeCubit, BikeState>(
            builder: (context, state) {
              if (state is BikeFetchingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (state is BikeToolKitFetchedState) {
                return Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: ListView.builder(
                        itemCount: state.toolKit.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                EdgeInsets.only(left: 30, top: 30, right: 30),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                              state.toolKit[index]["toolName"]),
                                          content: Text(state.toolKit[index]
                                              ["toolDescription"]),
                                        ));
                              },
                              child: ToolKit(
                                toolDescription: state.toolKit[index]
                                    ["toolDescription"],
                                toolImage: state.toolKit[index]["tookImage"],
                                toolName: state.toolKit[index]["toolName"],
                              ),
                            ),
                          );
                          ;
                        }));
              } else
                return Center(
                    child: Text(
                  "No match Found",
                  style: TextStyle(color: Colors.orange),
                ));
            },
          ),
          Column(
            children: [
              Container(
                color: Colors.white,
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  onSubmitted: (value) {
                    BlocProvider.of<BikeCubit>(context).getToolKit(value);
                  },
                  decoration: InputDecoration(
                    labelText: "What do you want?",
                    labelStyle: GoogleFonts.roboto(
                        color: const Color.fromRGBO(166, 166, 166, 0.87),
                        fontSize: 14),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(194, 188, 188, 0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 4.0)),
                    suffixIcon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Color(0xff989898),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
