import 'package:flutter/material.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/models/distributor_model.dart';
import 'package:irrigalink/models/farmer_model.dart';
import 'package:irrigalink/services/distributor_provider.dart';
import 'package:provider/provider.dart';

class FarmerDetailPage extends StatelessWidget {
  final Farmer farmer;

  const FarmerDetailPage({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          S.of(context).farmer_detail,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(80, 255, 251, 251),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(0),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 2),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(farmer.profilePicture),
                      ),
                      Positioned(
                        left: 130,
                        top: 22,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textHeader(
                              "${S.of(context).name}: ${farmer.name}",
                            ),
                            textHeader(
                              "${S.of(context).experience}: ${farmer.experience} years",
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          farmer.status == "Online"
                              ? S.of(context).online
                              : S.of(context).offline,
                          style: const TextStyle(
                              color: Color.fromRGBO(67, 118, 108, 1),
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 2.5,
                  color: Color.fromARGB(255, 150, 205, 171),
                ),
                bottomInfo(
                  '${S.of(context).livingIn}, ${farmer.location}',
                  const Icon(
                    Icons.location_on_sharp,
                    color: Color.fromRGBO(187, 105, 105, 1),
                  ),
                ),
                bottomInfo(
                  '${S.of(context).phoneNo} : ${farmer.phoneNumber}',
                  const Icon(
                    Icons.phone,
                    color: Color.fromRGBO(1, 146, 103, 1),
                  ),
                ),
                bottomInfo(
                  S.of(context).cropsProduced,
                  Image.asset(
                    'images/vegetable.png',
                    width: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: farmer.cropsProduced.map((crop) {
                      return Chip(
                        side: const BorderSide(color: Colors.white),
                        label: Text(
                          crop,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(
                            98, 142, 144, 1), // Customize the background color
                        elevation: 2, // Add elevation for a shadow effect
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                bottomInfo(
                  S.of(context).farmImage,
                  Image.asset(
                    'images/farm image icon.png',
                    width: 25,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(farmer.farmImage),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Distributor distributor =
                        Provider.of<DistributorProvider>(context, listen: false)
                            .distributor!;

                    Navigator.of(context).pushNamed('/chat_detail',
                        arguments: [distributor, farmer]);
                  },
                  style: ElevatedButton.styleFrom(
                    // Set the background color
                    backgroundColor: const Color.fromRGBO(98, 142, 144, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Set the border radius
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0), // Set padding
                  ),
                  child: Text(
                    S.of(context).startChat,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Inter' // Set text color
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding bottomInfo(String text, Widget iconData) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          iconData,
          const SizedBox(
            width: 9,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Padding textHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
