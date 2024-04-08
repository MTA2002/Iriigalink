import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:irrigalink/models/market_price_model.dart';

class MarketPriceService {
  static final CollectionReference _marketPrices =
      FirebaseFirestore.instance.collection('market_price');

  static Stream<List<MarketPrice>> getMarketPriceStream() {
    return _marketPrices.orderBy('updateTime').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MarketPrice.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
