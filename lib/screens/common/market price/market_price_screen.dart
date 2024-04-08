import 'package:flutter/material.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/models/market_price_model.dart';
import 'package:irrigalink/screens/common/market%20price/market_price_card.dart';
import 'package:irrigalink/services/market_price_service.dart';

class MarketPriceList extends StatelessWidget {
  const MarketPriceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchBar(context),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: StreamBuilder<List<MarketPrice>>(
            stream: MarketPriceService.getMarketPriceStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text(
                  S.of(context).no_farmers_yet,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                );
              } else {
                List<MarketPrice> marketPrices = snapshot.data!;
                return ListView(
                  children: [
                    Wrap(
                      spacing: 18.0, // Adjust the spacing between items
                      runSpacing: 8.0, // Adjust the spacing between rows
                      children: marketPrices.map((marketPrice) {
                        return MarketPriceCard(marketPrice: marketPrice);
                      }).toList(),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

Widget searchBar(BuildContext context) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(120, 130, 157, 0.1),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30,
                    ),
                    hintText: S.of(context).looking_for,
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(120, 130, 157, 0.9),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: TextButton(
          onPressed: () {
            _buildCropsDialogContent(context);
          },
          child: Image.asset(
            "images/filter.png",
            height: 35,
          ),
        ),
      )
    ],
  );
}

Future<dynamic> dialogSearch(BuildContext context, List<Widget> options) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: const Color.fromRGBO(9, 38, 53, 1),
        content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: options)),
      );
    },
  );
}

List<String> initCrops(BuildContext context) {
  List<String> crops = [];
  crops.add(S.of(context).onion);
  crops.add(S.of(context).tomato);
  crops.add(S.of(context).wheat);
  crops.add(S.of(context).corn);
  crops.add(S.of(context).rice);
  crops.add(S.of(context).barley);
  crops.add(S.of(context).teff);
  crops.add(S.of(context).sorghum);
  crops.add(S.of(context).cofee);
  crops.add(S.of(context).khat);
  crops.add(S.of(context).potato);
  return crops;
}

void _buildCropsDialogContent(BuildContext context) {
  final List<String> filteringOptions = initCrops(context);
  dialogSearch(
    context,
    filteringOptions.map((option) {
      return Padding(
        padding: const EdgeInsets.all(13.0),
        child: filterButton(context, option, () {}),
      );
    }).toList(),
  );
}

ElevatedButton filterButton(
    BuildContext context, String text, Function()? onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      // Text color
      backgroundColor: const Color.fromARGB(175, 200, 173, 1),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      minimumSize: const Size(220, 20),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        fontFamily: 'Inter',
      ),
    ),
  );
}
