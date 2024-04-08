import 'package:flutter/material.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/models/market_price_model.dart';

class MarketPriceCard extends StatelessWidget {
  const MarketPriceCard({super.key, required this.marketPrice});
  final MarketPrice marketPrice;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> cropNameMap = {
      "onion": S.of(context).onion,
      "tomato": S.of(context).tomato,
      "wheat": S.of(context).wheat,
      "sorghum": S.of(context).sorghum,
      "teff": S.of(context).teff,
      "rice": S.of(context).rice,
      "corn": S.of(context).corn,
      "barley": S.of(context).barley,
      "cofee": S.of(context).cofee,
      "khat": S.of(context).khat,
      "potato": S.of(context).potato,
    };
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/market_price_detail', arguments: marketPrice);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: 200, // Adjust the height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(marketPrice.cropImage),
                fit: BoxFit.cover, // Make the image fully occupy the container
              ),
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 20,
            child: Wrap(
              spacing: MediaQuery.of(context).size.width,
              children: [
                textProduct(cropNameMap[marketPrice.cropName.toLowerCase()]),
                textProduct('${marketPrice.currentPrice} ${S.of(context).birr}')
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Text textProduct(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
