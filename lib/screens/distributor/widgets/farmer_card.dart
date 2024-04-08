import 'package:flutter/material.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/models/farmer_model.dart';

class FarmerCard extends StatelessWidget {
  const FarmerCard({super.key, required this.farmer});
  final Farmer farmer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/farmer_detail', arguments: farmer);
      },
      child: Card(
        elevation: 1,
        child: Container(
          padding: const EdgeInsets.all(0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 252, 250, 250),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(255, 150, 205, 171),
              width: 3,
            ),
          ),
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
                        top: 29,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textHeader(
                              "${S.of(context).name}: ${farmer.name}",
                            ),
                            textHeader(
                              "${S.of(context).experience}: ${farmer.experience} ${S.of(context).years}",
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
                  '${S.of(context).phoneNo}: ${farmer.phoneNumber}',
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
                        backgroundColor: const Color.fromRGBO(98, 142, 144, 1),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      );
                    }).toList(),
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
          overflow: TextOverflow.fade,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
