import 'package:bikerider/custom/widgets/accessoriesCard.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessoriesScreen extends StatefulWidget {
  const AccessoriesScreen({super.key});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
  TextEditingController searchCardController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFEDC2),
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
          Padding(
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
              itemCount: 8,
              itemBuilder: (context, index) => const AccessoriesCard(),
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.white,
                height: 20,
              ),
              TextField(
                controller: searchCardController,
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
