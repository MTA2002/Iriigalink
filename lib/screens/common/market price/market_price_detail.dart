import 'package:flutter/material.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/models/market_price_model.dart';

class MarketPriceDetailPage extends StatelessWidget {
  final MarketPrice marketPrice;

  const MarketPriceDetailPage({Key? key, required this.marketPrice})
      : super(key: key);

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
          marketPrice.cropName,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: const Color(0xfffffbfb),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(marketPrice.cropImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.local_florist,
                  size: 30, color: Colors.green),
              title: textTile(marketPrice.cropName),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.attach_money,
                  size: 30, color: Colors.orange),
              title: textTile(
                  '${S.of(context).current_price}: ${marketPrice.currentPrice} birr'),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading:
                  const Icon(Icons.straighten, size: 30, color: Colors.blue),
              title: textTile(
                  '${S.of(context).price_unit}: ${marketPrice.priceUnit}'),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading:
                  const Icon(Icons.access_time, size: 30, color: Colors.grey),
              title: textTile(
                  '${S.of(context).update_time}: ${marketPrice.updateTime}'),
            ),
          ],
        ),
      ),
    );
  }

  Text textTile(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
