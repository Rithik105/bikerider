import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/UserModel.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/accessoriesCard.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessoriesScreen extends StatefulWidget {
  const AccessoriesScreen({super.key});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
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
          'Accessories',
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
              if (state is BikeFetchingState)
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.orange,
                ));
              else if (state is BikeAccFetchedState) {
                return Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1 / 2,
                      mainAxisExtent: 230,
                      crossAxisCount: 2,
                    ),
                    itemCount: state.accessories.length,
                    itemBuilder: (context, index) => Container(
                      color: Color(0XFFFFEDC2),
                      padding: EdgeInsets.all(1),
                      child: AccessoriesCard(
                        productId: state.accessories[index]["_id"],
                        productLike: state.accessories[index]["likes"],
                        productImage: state.accessories[index]["productImage"],
                        productName: state.accessories[index]["productName"],
                        productPrice: state.accessories[index]["productPrice"],
                        createdDate:
                            DateTime.parse(state.accessories[index]["created"]),
                        category: state.accessories[index]["category"],
                      ),
                    ),
                  ),
                );
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
              TextField(
                onSubmitted: (value) {
                  BlocProvider.of<BikeCubit>(context).getAcc(value);
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
            ],
          ),
        ],
      ),
    );
  }
}
